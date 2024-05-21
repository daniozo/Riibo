const express = require('express');
const app = express();
const port = 3000;
const { connectDB, sequelize } = require('./config/dbConfig');

connectDB();

const userRoutes = require('./routes / userRoutes');
const articleRoutes = require('./routes/articleRoutes');

app.use(express.json());

app.use('/api/users', userRoutes);
app.use('/api/articles', articleRoutes);

sequelize.sync().then(() => {
  app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
  });
}).catch((error) => {
  console.error('Erreur lors de la synchronisation de la base de données:', error);
});
