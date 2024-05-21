const express = require('express');
const router = express.Router();
const { getRecentArticles, getArticlesByFilters } = require('../controllers/articleController');

router.get('/recent', getRecentArticles);
router.get('/by-filters', getArticlesByFilters);


module.exports = router;
