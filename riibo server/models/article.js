const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/dbConfig');
const Business = require('./business');

const Article = sequelize.define('Article', {
  article_id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  name: {
    type: DataTypes.STRING(255),
    allowNull: false
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  initial_price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false
  },
  sale_price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: true
  },
  quantity: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  },
  available_until: {
    type: DataTypes.DATE,
    allowNull: true
  },
  status: {
    type: DataTypes.ENUM('disponible', 'vendu', 'expiré'),
    allowNull: false
  }, 
  images: {
    type: DataTypes.JSON,
    allowNull: true
  },
  business_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Business,
      key: 'business_id'
    },
    allowNull: false
  },
  coordinates: {
    type: DataTypes.GEOMETRY('POINT'),
    allowNull: false
  },
  business_name: {
    type: DataTypes.STRING(255),
    allowNull: false
  },
}, {
  tableName: 'Articles',
  timestamps: false
});

Article.belongsTo(Business, { foreignKey: 'business_id' });

module.exports = Article;
