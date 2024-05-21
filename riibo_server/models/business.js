const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/dbConfig');

const Business = sequelize.define('Business', {
  business_id: {
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
  address: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  coordinates: {
    type: DataTypes.GEOMETRY('POINT'),
    allowNull: false
  },
  contact_phone: {
    type: DataTypes.STRING(20),
    allowNull: true
  },
  contact_email: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  logo_url: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  opening_hours: {
    type: DataTypes.TIME,
    allowNull: true
  },
  closing_hours: {
    type: DataTypes.TIME,
    allowNull: true
  },
  business_type: {
    type: DataTypes.STRING(50),
    allowNull: false
  },
}, {
  tableName: 'Business',
  timestamps: false
})

module.exports = Business;
