'use strict';
const { sanitizeEntity } = require('strapi-utils');
const { orderByDistance } = require('geolib');
// import { orderByDistance } from 'geolib';


/**
 * Read the documentation (https://strapi.io/documentation/developer-docs/latest/concepts/controllers.html#core-controllers)
 * to customize this controller
 * 
 * local() is a new custom controller which does not come with standard strapi, its purpose is to query for all results
 * then order the results by nearest distance to a specific set of coordinates.
 */


module.exports = {
  async local(ctx) {
    let entities;
    if (ctx.query._q) {
        entities = await strapi.services.post.search(ctx.query);
    } else if (ctx.query.longitude && ctx.query.latitude) {
        const location = { // store coords in new object
            longitude: ctx.query.longitude,
            latitude: ctx.query.latitude
        }
        // delete the coord values from the original query object so it doesnt affect the results, all other queries will remain
        delete ctx.query.longitude;
        delete ctx.query.latitude;

        const unordered_entities = await strapi.services.post.find(ctx.query); // fetch the results (without the coords)
        // order the results using geolib library
        entities = orderByDistance({ latitude: location.latitude, longitude: location.longitude }, unordered_entities);
    } else {
        console.log('third catch')
        entities = await strapi.services.post.find(ctx.query);
    }

    return entities.map(entity => sanitizeEntity(entity, { model: strapi.models.post }));
  },
};
