package net.syscon.elite.api.model.v1;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.validation.constraints.NotNull;

@ApiModel(description = "Transaction Response")
@Data
@AllArgsConstructor
@Builder
@EqualsAndHashCode
@ToString
public class Transaction {
    @ApiModelProperty(value = "ID of created transaction", example = "6179604-1")
    @NotNull
    private String id;
}