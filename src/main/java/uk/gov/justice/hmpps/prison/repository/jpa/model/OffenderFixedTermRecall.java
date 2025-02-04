package uk.gov.justice.hmpps.prison.repository.jpa.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import uk.gov.justice.hmpps.prison.api.model.FixedTermRecallDetails;
import uk.gov.justice.hmpps.prison.api.model.ReturnToCustodyDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import java.time.LocalDate;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"bookingId"}, callSuper = false)
@Table(name = "OFFENDER_FIXED_TERM_RECALLS")
public class OffenderFixedTermRecall extends AuditableEntity {

    @Id
    @Column(name = "OFFENDER_BOOK_ID")
    private Long bookingId;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "OFFENDER_BOOK_ID", nullable = false)
    @PrimaryKeyJoinColumn
    private OffenderBooking offenderBooking;

    @Column(name = "RETURN_TO_CUSTODY_DATE")
    private LocalDate returnToCustodyDate;

    @Column(name = "RECALL_LENGTH")
    private Integer recallLength;

    public ReturnToCustodyDate mapToReturnToCustody() {
        return ReturnToCustodyDate.builder()
            .bookingId(offenderBooking.getBookingId())
            .returnToCustodyDate(returnToCustodyDate)
            .build();
    }

    public FixedTermRecallDetails mapToFixedTermRecallDetails() {
        return FixedTermRecallDetails.builder()
            .bookingId(offenderBooking.getBookingId())
            .returnToCustodyDate(returnToCustodyDate)
            .recallLength(recallLength)
            .build();
    }
}
