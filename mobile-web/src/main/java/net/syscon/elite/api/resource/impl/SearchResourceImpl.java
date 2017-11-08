package net.syscon.elite.api.resource.impl;

import net.syscon.elite.api.model.OffenderBooking;
import net.syscon.elite.api.resource.SearchOffenderResource;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.core.RestResource;
import net.syscon.elite.service.InmateService;

import javax.ws.rs.Path;

import static net.syscon.util.ResourceUtils.nvl;

@RestResource
@Path("search-offenders")
public class SearchResourceImpl implements SearchOffenderResource {
    private final InmateService inmateService;

    public SearchResourceImpl(InmateService inmateService) {
        this.inmateService = inmateService;
    }

    @Override
    public SearchForOffendersLocationOnlyResponse searchForOffendersLocationOnly(String locationPrefix, Long pageOffset, Long pageLimit, String sortFields, Order sortOrder) {
        Page<OffenderBooking> offenders = inmateService.findOffenders(
                null,
                locationPrefix,
                sortFields,
                sortOrder,
                nvl(pageOffset, 0L),
                nvl(pageLimit, 10L));

        return SearchForOffendersLocationOnlyResponse.respond200WithApplicationJson(offenders);
    }

    @Override
    public SearchForOffendersLocationAndKeywordResponse searchForOffendersLocationAndKeyword(String locationPrefix, String keywords, Long pageOffset, Long pageLimit, String sortFields, Order sortOrder) {
        Page<OffenderBooking> offenders = inmateService.findOffenders(
                keywords,
                locationPrefix,
                sortFields,
                sortOrder,
                nvl(pageOffset, 0L),
                nvl(pageLimit, 10L));

        return SearchForOffendersLocationAndKeywordResponse.respond200WithApplicationJson(offenders);
    }
}
