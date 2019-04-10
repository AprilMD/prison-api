package net.syscon.elite.repository;

import net.syscon.elite.api.model.Location;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface LocationRepository {
	Optional<Location> getLocation(long locationId);

	@Deprecated
	Optional<Location> findLocation(long locationId, String username);

    /**
     * Return a List of Location that match the supplied search criteria (The result is really set represented by a list)
     * @param agencyId Location must be within the specified agency
     * @param locationType 'WING', 'CELL' etc.
     * @param noParentLocation if true exclude any Location that has a parent
     * @return The matching set of Location.  Note that:
     *   The locationPrefix is replaced by description if present and
     *   The description is replaced by userDescription if it exists otherwise the description has its agency prefix removed.
     */
	List<Location> findLocationsByAgencyAndType(String agencyId, String locationType, boolean noParentLocation);

	List<Location> getLocationGroupData(final String agencyId);
	List<Location> getSubLocationGroupData(Set<Long> parentLocationIds);
	}
