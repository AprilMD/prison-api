package uk.gov.justice.hmpps.prison.repository.jpa.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Entity
@Table(name = "reference_domains")
public class ReferenceDomain {
    @Id
    @Column
    private String domain;
    @Column
    private String description;
    @Column
    private String domainStatus;
    @Column
    private String ownerCode;
    @Column
    private String applnCode;
    @Column
    private String parentDomain;
}
