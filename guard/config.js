'use strict';
require('dotenv').config();

module.exports.PORT = process.env.GUARD_PORT;
module.exports.PASSWORD = process.env.GUARD_PASSWORD;

module.exports.WG_PATH = process.env.GUARD_PATH;
module.exports.WG_DEVICE = process.env.GUARD_DEVICE;
module.exports.WG_HOST = process.env.GUARD_HOST;
module.exports.WG_PORT = process.env.GUARD_FRONT_PORT;
module.exports.WG_MTU = process.env.GUARD_MTU;
module.exports.WG_PERSISTENT_KEEPALIVE = process.env.GUARD_PERSISTENT_KEEPALIVE;
module.exports.WG_DEFAULT_ADDRESS = process.env.GUARD_DEFAULT_ADDRESS;
module.exports.WG_DEFAULT_DNS = process.env.GUARD_DEFAULT_DNS;
module.exports.WG_ALLOWED_IPS = process.env.GUARD_ALLOWED_IPS;
module.exports.WG_PRE_UP = process.env.GUARD_PRE_UP;
module.exports.WG_POST_UP = process.env.GUARD_POST_UP;
module.exports.WG_PRE_DOWN = process.env.GUARD_PRE_DOWN;
module.exports.WG_POST_DOWN = process.env.GUARD_POST_DOWN;
