const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/dbConfig');
const User = require('./user');
const Article = require('./article');
const Business = require('./business');

const Favorite = sequelize.define('Favorite', {
  favorite_id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  user_id: {
    type: DataTypes.INTEGER,
    references: {
      model: User,
      key: 'user_id'
    },
    allowNull: false
  },
  article_or_business_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  favorite_type: {
    type: DataTypes.ENUM('commerce', 'article'),
    allowNull: false
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  }
}, {
  tableName: 'favorites',
  timestamps: false
});


Favorite.belongsTo(User, { foreignKey: 'user_id' });
Favorite.belongsTo(Article, { foreignKey: 'article_or_business_id', constraints: false });
Favorite.belongsTo(Business, { foreignKey: 'article_or_business_id', constraints: false });

module.exports = Favorite;
