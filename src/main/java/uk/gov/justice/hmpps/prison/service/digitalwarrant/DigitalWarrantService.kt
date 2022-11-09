package uk.gov.justice.hmpps.prison.service.digitalwarrant

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import uk.gov.justice.hmpps.prison.api.model.digitalwarrant.CourtCase
import uk.gov.justice.hmpps.prison.api.model.digitalwarrant.Sentence
import uk.gov.justice.hmpps.prison.repository.jpa.model.*
import uk.gov.justice.hmpps.prison.repository.jpa.repository.*
import uk.gov.justice.hmpps.prison.service.EntityNotFoundException
import java.time.LocalDateTime
import javax.transaction.Transactional

@Service
class DigitalWarrantService(
  private val offenderCourtCaseRepository: OffenderCourtCaseRepository,
  private val offenderChargeRepository: OffenderChargeRepository,
  private val offenderSentenceRepository: OffenderSentenceRepository,
  private val agencyLocationRepository: AgencyLocationRepository,
  private val offenceRepository: OffenceRepository,
  private val offenderBookingRepository: OffenderBookingRepository,
  private val sentenceCalcTypeRepository: SentenceCalcTypeRepository,
  private val offenderSentenceChargeRepository: OffenderSentenceChargeRepository,
  private val legalCaseTypeReferenceCodeRepository: ReferenceCodeRepository<LegalCaseType>,
  private val movementReasonReferenceCodeRepository: ReferenceCodeRepository<MovementReason>,
  private val caseStatusReferenceCodeRepository: ReferenceCodeRepository<CaseStatus>,
  private val eventStatusReferenceCodeRepository: ReferenceCodeRepository<EventStatus>,
  private val offenceResultRepository: OffenceResultRepository,
  private val sentenceTermRepository: SentenceTermRepository,
  private val courtOrderRepository: CourtOrderRepository,
  private val courtEventRepository: CourtEventRepository,
  private val courtEventChargeRepository: CourtEventChargeRepository,
  private val imprisonmentStatusRepository: ImprisonmentStatusRepository) {

  @Transactional
  fun createCourtCase(bookingId: Long, courtCase: CourtCase): Long {
    val agency = agencyLocationRepository.findById(courtCase.agencyId).orElseThrow(EntityNotFoundException.withIdAndClass(courtCase.agencyId, CourtCase::class.java))
    val legalCaseType = legalCaseTypeReferenceCodeRepository.findById(LegalCaseType.pk(courtCase.caseType)).orElseThrow(EntityNotFoundException.withIdAndClass(courtCase.caseType, LegalCaseType::class.java))
    val booking = offenderBookingRepository.findByBookingId(bookingId).orElseThrow(EntityNotFoundException.withIdAndClass(bookingId, OffenderBooking::class.java))
    val caseStatus = caseStatusReferenceCodeRepository.findById(CaseStatus.pk("A")).orElseThrow(EntityNotFoundException.withIdAndClass("A", CaseStatus::class.java))
    val sequence = offenderCourtCaseRepository.findAllByOffenderBooking_BookingId(bookingId).stream().max(Comparator.comparing { obj: OffenderCourtCase -> obj.caseSeq }).map { occ: OffenderCourtCase -> occ.caseSeq + 1 }.orElse(1L)
    val offenderCourtCase = OffenderCourtCase()
      .withCaseInfoNumber(courtCase.caseInfoNumber)
      .withLegalCaseType(legalCaseType)
      .withAgencyLocation(agency)
      .withBeginDate(courtCase.beginDate)
      .withOffenderBooking(booking)
      .withCaseSeq(sequence)
      .withCaseStatus(caseStatus)
    val movementReason = movementReasonReferenceCodeRepository.findById(MovementReason.pk(courtCase.hearingType)).orElseThrow(EntityNotFoundException.withIdAndClass(courtCase.caseType, MovementReason::class.java))
    val eventStatus = eventStatusReferenceCodeRepository.findById(EventStatus.COMPLETED).orElseThrow(EntityNotFoundException.withIdAndClass(EventStatus.COMPLETED.code, EventStatus::class.java))
    val courtEvent = CourtEvent()
      .withOffenderBooking(booking)
      .withCourtEventType(movementReason)
      .withEventStatus(eventStatus)
      .withStartTime(courtCase.beginDate.atTime(10, 0))
      .withEventDate(courtCase.beginDate)
      .withCourtLocation(agency)
      .withOffenderCourtCase(offenderCourtCase)
    courtEventRepository.save(courtEvent)
    return offenderCourtCaseRepository.save(offenderCourtCase).id
  }

  @Transactional
  fun createOffenderOffence(bookingId: Long?, offenderOffence: uk.gov.justice.hmpps.prison.api.model.digitalwarrant.Offence): Long {
    val offence = offenceRepository.findById(Offence.PK(offenderOffence.offenceCode, offenderOffence.offenceStatue)).orElseThrow(EntityNotFoundException.withIdAndClass(offenderOffence.offenceCode + " " + offenderOffence.offenceStatue, uk.gov.justice.hmpps.prison.api.model.digitalwarrant.Offence::class.java))
    val courtCase = offenderCourtCaseRepository.findById(offenderOffence.courtCaseId).orElseThrow(EntityNotFoundException.withIdAndClass(offenderOffence.courtCaseId, OffenderCourtCase::class.java))
    val booking = offenderBookingRepository.findByBookingId(bookingId).orElseThrow(EntityNotFoundException.withIdAndClass(bookingId!!, OffenderBooking::class.java))
    val offenceResultCode = if (offenderOffence.isGuilty) OffenceResultRepository.IMPRISONMENT else OffenceResultRepository.NOT_GUILTY
    val result = offenceResultRepository.findById(offenceResultCode).orElseThrow(EntityNotFoundException.withIdAndClass(offenceResultCode, OffenceResult::class.java))
    val otherCharges = offenderChargeRepository.findByOffenderBooking_BookingId(bookingId)
    val mostSeriousCharge = otherCharges.stream().filter { charge: OffenderCharge -> charge.mostSeriousFlag == "Y" }.findFirst()
    val mostSerious = mostSeriousCharge.map { charge: OffenderCharge -> offence.isMoreSeriousThan(charge.offence) }.orElse(true)
    var offenderCharge = OffenderCharge()
      .withOffence(offence)
      .withDateOfOffence(offenderOffence.offenceDate)
      .withEndDate(offenderOffence.offenceEndDate)
      .withOffenderCourtCase(courtCase)
      .withOffenderBooking(booking)
      .withResultCodeOne(result)
      .withResultCodeOneIndicator("F")
      .withMostSeriousFlag(if (mostSerious) "Y" else "N")
      .withPleaCode("G")
    offenderCharge = offenderChargeRepository.save(offenderCharge)
    if (mostSerious && mostSeriousCharge.isPresent) {
      mostSeriousCharge.get().mostSeriousFlag = "N"
      offenderChargeRepository.save(mostSeriousCharge.get())
    }
    return offenderCharge.id
  }

  @Transactional
  fun createOffenderSentence(bookingId: Long, sentence: Sentence): Int {
    val courtCase = offenderCourtCaseRepository.findById(sentence.courtCaseId).orElseThrow(EntityNotFoundException.withIdAndClass(sentence.courtCaseId, CourtCase::class.java))
    val booking = offenderBookingRepository.findByBookingId(bookingId).orElseThrow(EntityNotFoundException.withIdAndClass(bookingId, OffenderBooking::class.java))
    val offenderCharge = offenderChargeRepository.findById(sentence.offenderChargeId).orElseThrow(EntityNotFoundException.withIdAndClass(sentence.offenderChargeId, OffenderCharge::class.java))
    val sentenceCalcType = sentenceCalcTypeRepository.findById(SentenceCalcType.PK(sentence.sentenceType, sentence.sentenceCategory)).orElseThrow(EntityNotFoundException.withIdAndClass(sentence.sentenceType + " " + sentence.sentenceCategory, SentenceCalcType::class.java))
    val movementReason = movementReasonReferenceCodeRepository.findById(MovementReason.SENTENCING).orElseThrow(EntityNotFoundException.withIdAndClass(MovementReason.SENTENCING.code, MovementReason::class.java))
    val eventStatus = eventStatusReferenceCodeRepository.findById(EventStatus.COMPLETED).orElseThrow(EntityNotFoundException.withIdAndClass(EventStatus.COMPLETED.code, EventStatus::class.java))
    val result = offenceResultRepository.findById(OffenceResultRepository.IMPRISONMENT).orElseThrow(EntityNotFoundException.withIdAndClass(OffenceResultRepository.IMPRISONMENT, OffenceResult::class.java))
    val courtEvent = CourtEvent()
      .withOffenderBooking(booking)
      .withCourtEventType(movementReason)
      .withEventStatus(eventStatus)
      .withStartTime(sentence.sentenceDate.atTime(10, 0))
      .withEventDate(sentence.sentenceDate)
      .withCourtLocation(courtCase.agencyLocation)
      .withOffenderCourtCase(courtCase)
      .withOutcomeReasonCode(result)
    courtEventRepository.save(courtEvent)
    val courtEventCharge = CourtEventCharge(offenderCharge, courtEvent)
    courtEventChargeRepository.save(courtEventCharge)
    var courtOrder = CourtOrder()
      .withCourtCase(courtCase)
      .withIssuingCourt(courtCase.agencyLocation)
      .withCourtDate(sentence.sentenceDate)
      .withOffenderBooking(booking)
      .withOrderType("AUTO")
      .withOrderStatus("A")
      .withCourtEvent(courtEvent)
    courtOrder = courtOrderRepository.save(courtOrder)
    val sequence = offenderSentenceRepository.findByOffenderBooking_BookingId(bookingId).stream().max(Comparator.comparing { obj: OffenderSentence -> obj.sequence }).map { os: OffenderSentence -> os.sequence + 1 }.orElse(1)
    var offenderSentence = OffenderSentence()
      .withId(OffenderSentence.PK(booking.bookingId, sequence))
      .withLineSequence(java.lang.Long.valueOf(sequence.toLong()))
      .withCalculationType(sentenceCalcType)
      .withSentenceStartDate(sentence.sentenceDate)
      .withCourtCase(courtCase)
      .withCourtOrder(courtOrder)
      .withStatus("A")
    offenderSentence = offenderSentenceRepository.save(offenderSentence)
    val term = SentenceTerm()
      .withDays(sentence.days)
      .withWeeks(sentence.weeks)
      .withMonths(sentence.months)
      .withYears(sentence.years)
      .withSentenceTermCode("IMP")
      .withStartDate(sentence.sentenceDate)
      .withId(SentenceTerm.PK(booking.bookingId, offenderSentence.sequence, 1))
    sentenceTermRepository.save(term)
    val offenderSentenceCharge = OffenderSentenceCharge()
      .withId(OffenderSentenceCharge.PK(booking.bookingId, offenderSentence.sequence, offenderCharge.id))
    offenderSentenceChargeRepository.save(offenderSentenceCharge)
    val status = imprisonmentStatusRepository.findByStatusAndActive(sentence.sentenceType, true)
      .orElseGet {
        imprisonmentStatusRepository.findByStatusAndActive(ImprisonmentStatusRepository.ADULT_IMPRISONMENT_WITHOUT_OPTION, true)
          .orElseThrow(EntityNotFoundException.withIdAndClass(sentence.sentenceType, ImprisonmentStatus::class.java))
      }
    booking.setImprisonmentStatus(
      OffenderImprisonmentStatus()
        .withImprisonmentStatus(status)
        .withAgyLocId(booking.location.id),
      LocalDateTime.now()
    )
    return offenderSentence.sequence
  }
}