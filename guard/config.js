'use strict';
require('dotenv').config();

module.exports.PORT = process.env.PORT;
module.exports.PASSWORD = process.env.PASSWORD;

module.exports.WG_PATH = process.env.WG_PATH;
module.exports.WG_DEVICE = process.env.WG_DEVICE;
module.exports.WG_HOST = process.env.WG_HOST;
module.exports.WG_PORT = process.env.WG_PORT;
module.exports.WG_MTU = process.env.WG_MTU;
module.exports.WG_PERSISTENT_KEEPALIVE = process.env.WG_PERSISTENT_KEEPALIVE;
module.exports.WG_DEFAULT_ADDRESS = process.env.WG_DEFAULT_ADDRESS;
module.exports.WG_DEFAULT_DNS = process.env.WG_DEFAULT_DNS;
module.exports.WG_ALLOWED_IPS = process.env.WG_ALLOWED_IPS;
module.exports.WG_PRE_UP = process.env.WG_PRE_UP;
module.exports.WG_POST_UP = process.env.WG_POST_UP;
module.exports.WG_PRE_DOWN = process.env.WG_PRE_DOWN;
module.exports.WG_POST_DOWN = process.env.WG_POST_DOWN;
