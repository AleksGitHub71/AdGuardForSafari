const subscriptions = require('./subscriptions');

/**
 * Filter tags service
 */
module.exports = (() =>{

    'use strict';

    /**
     * Recommended tag identifier
     *
     * @type {number}
     */
    const RECOMMENDED_TAG_ID = 10;

    /**
     * All tags
     */
    const getTags = () => subscriptions.getTags();

    /**
     * Is filter recommended
     *
     * @param filter
     * @returns {boolean}
     */
    const isRecommendedFilter = (filter) => {
        return filter.tags.includes(RECOMMENDED_TAG_ID);
    };

    /**
     * Filters by tag identifier
     *
     * @param tagId
     * @param filters
     */
    const getFiltersByTagId = (tagId, filters) => filters.filter(f => f.tags.indexOf(tagId) >= 0);

    /**
     * Recommended filters
     *
     * @param filters
     */
    const getRecommendedFilters = filters => getFiltersByTagId(RECOMMENDED_TAG_ID, filters);

    return {
        getTags,
        getRecommendedFilters,
        isRecommendedFilter
    };
})();
