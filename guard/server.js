'use strict';

require('./services/Server');

const WireGuard = require('./services/WireGuard');

WireGuard.getConfig().catch(err => {
    console.error(err);
    process.exit(1);
});
