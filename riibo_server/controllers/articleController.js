const { Op } = require('sequelize');
const Article = require('../models/article');
const Business = require('../models/business');


exports.getRecentArticles = async (req, res) => {
  const twoDaysAgo = new Date();
  twoDaysAgo.setDate(twoDaysAgo.getDate() - 2);

  try {
    const articles = await Article.findAll({
      where: {
        created_at: {
          [Op.gte]: twoDaysAgo
        }
      }
    });
    res.json(articles);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.getArticlesByFilters = async (req, res) => {
  const { category } = req.query;
  let whereClause = {};

  if (req.query.within1km && req.query.userLatitude && req.query.userLongitude) {
    const userLatitude = parseFloat(req.query.userLatitude);
    const userLongitude = parseFloat(req.query.userLongitude);
    const distanceInMeters = 1000;

    whereClause = {
      ...whereClause,
      coordinates: sequelize.literal(`ST_Distance_Sphere(Point(business.coordinates), Point(${userLatitude}, ${userLongitude})) <= ${distanceInMeters}`)
    };
  }
  if (req.query.within2km) {
    const userLatitude = parseFloat(req.query.userLatitude);
    const userLongitude = parseFloat(req.query.userLongitude);
    const distanceInMeters = 2000;

    whereClause = {
      ...whereClause,
      coordinates: sequelize.literal(`ST_Distance_Sphere(Point(business.coordinates), Point(${userLatitude}, ${userLongitude})) <= ${distanceInMeters}`)
    };
  }
  if (req.query.newArticles) {
    const twoDaysAgo = new Date();
    twoDaysAgo.setDate(twoDaysAgo.getDate() - 2);
    whereClause = {
      ...whereClause,
      created_at: {
        [Op.gte]: twoDaysAgo
      }
    };
  }
  if (req.query.favoriteArticles) {
  }

  try {
    const articles = await Article.findAll({
      where: whereClause,
    });
    res.json(articles);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
