const { exec } = require('child_process');

function runCommand(command) {
    return new Promise((resolve, reject) => {
        exec(command, (error, stdout, stderr) => {
            if (error) {
                reject(error);
                return;
            }

            if (stderr) {
                reject(stderr);
                return;
            }

            resolve(stdout.trim());
        });
    });
}

async function getUnboundStats() {
    try {
        const command = 'unbound-control -c /etc/unbound/unbound.conf stats_noreset';
        const output = await runCommand(command);
        const stats = {};

        output.split('\n').forEach((line) => {
            const [key, value] = line.split('=');
            stats[key.trim()] = value.trim();
        });

        // Access individual values by their keys
        // create a JSON object with the data using stats not using the consts
        const unboundStats = {
            numQueries: stats['thread0.num.queries'],
            numQueriesIpRateLimited: stats['thread0.num.queries_ip_ratelimited'],
            numCacheHits: stats['thread0.num.cachehits'],
            numCacheMiss: stats['thread0.num.cachemiss'],
            numPrefetch: stats['thread0.num.prefetch'],
            numExpired: stats['thread0.num.expired'],
            numRecursiveReplies: stats['thread0.num.recursivereplies'],
            requestListAvg: stats['thread0.requestlist.avg'],
            requestListMax: stats['thread0.requestlist.max'],
            requestListOverwritten: stats['thread0.requestlist.overwritten'],
            requestListExceeded: stats['thread0.requestlist.exceeded'],
            requestListCurrentAll: stats['thread0.requestlist.current.all'],
            requestListCurrentUser: stats['thread0.requestlist.current.user'],
            recursionTimeAvg: stats['thread0.recursion.time.avg'],
            recursionTimeMedian: stats['thread0.recursion.time.median'],
            tcpUsage: stats['thread0.tcpusage'],
            totalNumQueries: stats['total.num.queries'],
            totalNumQueriesIpRateLimited: stats['total.num.queries_ip_ratelimited'],
            totalNumCacheHits: stats['total.num.cachehits'],
            totalNumCacheMiss: stats['total.num.cachemiss'],
            totalNumPrefetch: stats['total.num.prefetch'],
            totalNumExpired: stats['total.num.expired'],
            totalNumRecursiveReplies: stats['total.num.recursivereplies'],
            totalRequestListAvg: stats['total.requestlist.avg'],
            totalRequestListMax: stats['total.requestlist.max'],
            totalRequestListOverwritten: stats['total.requestlist.overwritten'],
            totalRequestListExceeded: stats['total.requestlist.exceeded'],
            totalRequestListCurrentAll: stats['total.requestlist.current.all'],
            totalRequestListCurrentUser: stats['total.requestlist.current.user'],
            totalRecursionTimeAvg: stats['total.recursion.time.avg'],
            totalRecursionTimeMedian: stats['total.recursion.time.median'],
            totalTimeNow: stats['time.now'],
            totalTimeUp: stats['time.up'],
            totalTimeElapsed: stats['time.elapsed'],
        };

        // print the JSON object to the console with 2 spaces for indentation
        console.log(JSON.stringify(unboundStats, null, 2));
    } catch (error) {
        console.error('Error executing command:', error);
    }
}

getUnboundStats();
