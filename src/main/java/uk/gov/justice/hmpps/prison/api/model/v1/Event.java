package uk.gov.justice.hmpps.prison.api.model.v1;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import uk.gov.justice.hmpps.prison.api.model.v1.Event.EventSerializer;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Schema(description = "Offender Event")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
@ToString
@JsonSerialize(using = EventSerializer.class)
public class Event {

    @Schema(description = "Type of event", required = true, example = "IEP_CHANGED")
    private String type;
    @Schema(description = "Unique indentifier for event", required = true, example = "21")
    private Long id;
    @Schema(name = "noms_id", description = "Offender Noms Id", example = "A1417AE", required = true)
    private String nomsId;
    @Schema(name = "prison_id", description = "Prison ID", example = "BMI", required = true)
    private String prisonId;
    @Schema(name = "timestamp", description = "Date and time the event occurred", example = "2016-10-21 15:55:06.284", required = true)
    private LocalDateTime timestamp;

    private String eventData;

    public static class EventSerializer extends JsonSerializer<Event> {
        private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

        public void serialize(final Event event, final JsonGenerator jgen, final SerializerProvider provider) throws IOException {
            jgen.writeStartObject();
            jgen.writeStringField("type", event.getType());
            jgen.writeNumberField("id", event.getId());
            jgen.writeStringField("noms_id", event.getNomsId());
            jgen.writeStringField("prison_id", event.getPrisonId());
            jgen.writeStringField("timestamp", event.getTimestamp().format(DATE_TIME_FORMATTER));
            // Write value as raw data, since it's already JSON text
            jgen.writeFieldName(event.getType().toLowerCase());
            jgen.writeRawValue(event.getEventData());
            jgen.writeEndObject();
        }
    }
}
