package uk.gov.justice.hmpps.prison.repository.jpa.model

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity

@Entity
@DiscriminatorValue(LivingUnitReferenceCode.DOMAIN)
class LivingUnitReferenceCode(code: String?, description: String?) : ReferenceCode(DOMAIN, code, description) {
  companion object {
    const val DOMAIN = "LIVING_UNIT"
  }
}
