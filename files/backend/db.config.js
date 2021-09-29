module.exports = {
	  HOST: "localhost",
	  USER: "backend",
	  PASSWORD: "backend",
	  DB: "tutorials",
	  dialect: "mysql",
	  pool: {
		      max: 5,
		      min: 0,
		      acquire: 30000,
		      idle: 10000
		    }
};
