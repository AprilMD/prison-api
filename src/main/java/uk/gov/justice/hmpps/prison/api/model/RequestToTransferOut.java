package uk.gov.justice.hmpps.prison.api.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

@Schema(description = "Represents the data required for transferring a prisoner to a new location")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
@ToString
public class RequestToTransferOut {

    @Schema(required = true, description = "The location to be moved to.", example = "PVI")
    @NotBlank(message = "The to location must be provided.")
    @Size(max = 6, message = "To location must be a maximum of 6 characters.")
    private String toLocation;

    @Schema(required = true, description = "The time the movement occurred, if not supplied it will be the current time. Note: Time can be in the past but not before the last movement", example = "2020-03-24T12:13:40")
    @org.springframework.format.annotation.DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime movementTime;

    @Schema(required = true, description = "The escort type of the move.", example = "PECS")
    @Size(max = 12, message = "Escort type must be a maximum of 12 characters.")
    private String escortType;

    @NotNull
    @Schema(description = "Reason code for the transfer, reference domain is MOVE_RSN", example = "NOTR")
    private String transferReasonCode;

    @Schema(description = "Additional comments about the release", example = "Prisoner was transferred to a new prison")
    @Length(max = 240, message = "Comments size is a maximum of 240 characters")
    private String commentText;

}
