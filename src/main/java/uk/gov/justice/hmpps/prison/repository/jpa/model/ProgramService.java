package uk.gov.justice.hmpps.prison.repository.jpa.model;

import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.Hidden;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@EqualsAndHashCode(callSuper = false)
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "PROGRAM_SERVICES")
public class ProgramService {

    @Id
    @Column(name = "PROGRAM_ID")
    private Long programId;

    @Column(name = "DESCRIPTION")
    @Schema(description = "Activity name")
    private String activity;

    @Column(name = "PROGRAM_CATEGORY")
    @Schema(description = "Program category")
    private String programCategory;

    @Column(name = "PROGRAM_CODE")
    @Schema(description = "Program code")
    private String programCode;

    @Column(name = "ACTIVE_FLAG")
    @Schema(description = "Active flag")
    private String activeFlag = "Y";
}
