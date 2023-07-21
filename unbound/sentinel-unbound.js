const http = require('http');
const fs = require('fs');
const { exec } = require('child_process');
require('dotenv').config();

const PORT = process.env.UNBOUND_FRONT_PORT;
const HTML_FILE = './www/index.html';
const STATS_UPDATE_INTERVAL = 5000; // Update interval in milliseconds

// Function to run the command and retrieve the stats
function getUnboundStats() {
    return new Promise((resolve, reject) => {
        const command = 'unbound-control -c /etc/unbound/unbound.conf stats_noreset';

        exec(command, (error, stdout, stderr) => {
            if (error) {
                reject(error);
                return;
            }

            if (stderr) {
                reject(stderr);
                return;
            }

            const stats = {};
            stdout.trim().split('\n').forEach((line) => {
                const [key, value] = line.split('=');
                stats[key.trim()] = value.trim();
            });

            resolve(stats);
        });
    });
}

// Function to update the HTML file with the latest stats
function updateHTML(stats) {
    fs.readFile(HTML_FILE, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading HTML file:', err);
            return;
        }

        // Replace the placeholder JSON data with the actual stats
        const updatedHTML = data.replace("/* REPLACE_STATS */", JSON.stringify(stats));

        // Write the updated HTML file
        fs.writeFile(HTML_FILE, updatedHTML, 'utf8', (err) => {
            if (err) {
                console.error('Error updating HTML file:', err);
            }
        });
    });
}

// Create an HTTP server to serve the HTML file
const server = http.createServer((req, res) => {
    fs.readFile(HTML_FILE, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading HTML file:', err);
            res.statusCode = 500;
            res.end('Internal Server Error');
            return;
        }

        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/html');
        res.end(data);
    });
});

// Start the server
server.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);

    // Start the stats update interval
    setInterval(() => {
        getUnboundStats()
            .then((stats) => {
                updateHTML(stats);
            })
            .catch((error) => {
                console.error('Error retrieving stats:', error);
            });
    }, STATS_UPDATE_INTERVAL);
});
