package net.syscon.elite.persistence.impl;

import jersey.repackaged.com.google.common.collect.ImmutableMap;
import net.syscon.elite.persistence.LocationRepository;
import net.syscon.elite.persistence.mapping.FieldMapper;
import net.syscon.elite.persistence.mapping.Row2BeanRowMapper;
import net.syscon.elite.security.UserSecurityUtils;
import net.syscon.elite.web.api.model.Location;
import net.syscon.elite.web.api.resource.LocationsResource.Order;
import net.syscon.util.IQueryBuilder;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public class LocationRepositoryImpl extends RepositoryBase implements LocationRepository {

	private final Map<String, FieldMapper> locationMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("INTERNAL_LOCATION_ID", 		new FieldMapper("locationId"))
		.put("AGY_LOC_ID", 					new FieldMapper("agencyId"))
		.put("INTERNAL_LOCATION_TYPE", 		new FieldMapper("locationType"))
		.put("DESCRIPTION", 				new FieldMapper("description"))
		.put("AGENCY_LOCATION_TYPE", 		new FieldMapper("agencyType"))
		.put("PARENT_INTERNAL_LOCATION_ID", new FieldMapper("parentLocationId"))
		.put("NO_OF_OCCUPANT", 				new FieldMapper("currentOccupancy")).build();

	@Override
	public Optional<Location> findLocation(Long locationId) {
		String sql = getQuery("FIND_LOCATION");

		RowMapper<Location> locationRowMapper = Row2BeanRowMapper.makeMapping(sql, Location.class, locationMapping);

		Location location;
		try {
			location = jdbcTemplate.queryForObject(sql,createParams("username", UserSecurityUtils.getCurrentUsername(), "locationId", locationId), locationRowMapper);
		} catch (EmptyResultDataAccessException e) {
			location = null;
		}
		return Optional.ofNullable(location);
	}

	@Override
	public List<Location> findLocations(String query, String orderByField, Order order, int offset, int limit) {
		String initialSql = getQuery("FIND_ALL_LOCATIONS");
		IQueryBuilder builder = queryBuilderFactory.getQueryBuilder(initialSql, locationMapping);
		boolean isAscendingOrder = (order == Order.asc);

		String sql = builder
				.addRowCount()
				.addQuery(query)
				.addOrderBy(isAscendingOrder, orderByField)
				.addPagination()
				.build();

		final RowMapper<Location> locationRowMapper =
				Row2BeanRowMapper.makeMapping(sql, Location.class, locationMapping);

		return jdbcTemplate.query(
				sql,
				createParams("username", UserSecurityUtils.getCurrentUsername(),
						"offset", offset,
						"limit", limit),
				locationRowMapper);
	}

	@Override
	public List<Location> findLocationsByAgencyId(final String caseLoadId, final String agencyId, final String query, final int offset, final int limit, final String orderByField, final Order order) {
		final String sql = queryBuilderFactory.getQueryBuilder(getQuery("FIND_LOCATIONS_BY_AGENCY_ID"), locationMapping).
						addRowCount().
						addQuery(query).
						addOrderBy(order == Order.asc, orderByField).
						addPagination()
						.build();
		final RowMapper<Location> locationRowMapper = Row2BeanRowMapper.makeMapping(sql, Location.class, locationMapping);
		return jdbcTemplate.query(sql, createParams("caseLoadId", caseLoadId, "agencyId", agencyId, "offset", offset, "limit", limit), locationRowMapper);
	}
}
