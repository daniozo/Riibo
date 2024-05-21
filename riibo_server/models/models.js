const User = require('./user');
const Business = require('./business');
const Article = require('./article');
const Favorite = require('./favorite');

Business.hasMany(Article, { foreignKey: 'business_id' });
Article.belongsTo(Business, { foreignKey: 'business_id' });

User.hasMany(Favorite, { foreignKey: 'user_id' });
Favorite.belongsTo(User, { foreignKey: 'user_id' });

Article.hasMany(Favorite, { foreignKey: 'article_or_business_id', constraints: false });
Business.hasMany(Favorite, { foreignKey: 'article_or_business_id', constraints: false });

module.exports = {
  User,
  Business,
  Article,
  Favorite
};
