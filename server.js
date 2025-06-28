const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// Server configuration
const PORT = process.env.PORT || 8000;
const HOST = '0.0.0.0';

// Safe MIME type lookup with input validation
function getMimeType(ext) {
    // Validate input is a string and starts with dot
    if (typeof ext !== 'string' || !ext.startsWith('.')) {
        return 'application/octet-stream';
    }
    
    // Use explicit switch for safer property access
    switch (ext) {
        case '.html': return 'text/html';
        case '.js': return 'text/javascript';
        case '.css': return 'text/css';
        case '.json': return 'application/json';
        case '.png': return 'image/png';
        case '.jpg': return 'image/jpg';
        case '.gif': return 'image/gif';
        case '.svg': return 'image/svg+xml';
        case '.wav': return 'audio/wav';
        case '.mp4': return 'video/mp4';
        case '.woff': return 'application/font-woff';
        case '.ttf': return 'application/font-ttf';
        case '.eot': return 'application/vnd.ms-fontobject';
        case '.otf': return 'application/font-otf';
        case '.wasm': return 'application/wasm';
        default: return 'application/octet-stream';
    }
}

// Create server
const server = http.createServer((req, res) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
    
    // Enable CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    // Handle OPTIONS preflight requests
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }
    
    try {
        // Parse URL
        const parsedUrl = url.parse(req.url);
        let pathname = parsedUrl.pathname;
        
        // Default to index.html for root
        if (pathname === '/') {
            pathname = '/index.html';
        }
        
        // API endpoints
        if (pathname.startsWith('/api/')) {
            handleApiRequest(req, res, pathname);
            return;
        }
        
        // Serve static files
        const filePath = path.join(__dirname, pathname);
        
        // Security check - prevent directory traversal
        if (!filePath.startsWith(__dirname)) {
            res.writeHead(403, { 'Content-Type': 'text/plain' });
            res.end('Forbidden');
            return;
        }
        
        // Check if file exists
        fs.access(filePath, fs.constants.F_OK, (err) => {
            if (err) {
                // File not found
                console.log(`File not found: ${filePath}`);
                
                // Try to serve index.html for SPA routing
                const indexPath = path.join(__dirname, 'index.html');
                fs.access(indexPath, fs.constants.F_OK, (indexErr) => {
                    if (indexErr) {
                        res.writeHead(404, { 'Content-Type': 'text/plain' });
                        res.end('File not found');
                    } else {
                        serveFile(indexPath, res);
                    }
                });
                return;
            }
            
            // Check if it's a directory
            fs.stat(filePath, (statErr, stats) => {
                if (statErr) {
                    res.writeHead(500, { 'Content-Type': 'text/plain' });
                    res.end('Internal Server Error');
                    return;
                }
                
                if (stats.isDirectory()) {
                    // Try to serve index.html in directory
                    const indexPath = path.join(filePath, 'index.html');
                    fs.access(indexPath, fs.constants.F_OK, (indexErr) => {
                        if (indexErr) {
                            // Serve directory listing
                            serveDirectoryListing(filePath, res, pathname);
                        } else {
                            serveFile(indexPath, res);
                        }
                    });
                } else {
                    // Serve the file
                    serveFile(filePath, res);
                }
            });
        });
        
    } catch (error) {
        console.error('Server error:', error);
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end('Internal Server Error');
    }
});

// Serve file function
function serveFile(filePath, res) {
    const ext = path.extname(filePath).toLowerCase();
    // Get MIME type safely
    const mimeType = getMimeType(ext);
    
    fs.readFile(filePath, (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            res.writeHead(500, { 'Content-Type': 'text/plain' });
            res.end('Error reading file');
            return;
        }
        
        res.writeHead(200, { 
            'Content-Type': mimeType,
            'Content-Length': data.length
        });
        res.end(data);
    });
}

// Serve directory listing
function serveDirectoryListing(dirPath, res, pathname) {
    fs.readdir(dirPath, (err, files) => {
        if (err) {
            res.writeHead(500, { 'Content-Type': 'text/plain' });
            res.end('Error reading directory');
            return;
        }
        
        let html = `<!DOCTYPE html>
<html>
<head>
    <title>Directory listing for ${pathname}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { border-bottom: 1px solid #ccc; padding-bottom: 10px; margin-bottom: 20px; }
        .file { padding: 5px 0; }
        .file a { text-decoration: none; color: #0066cc; }
        .file a:hover { text-decoration: underline; }
        .folder { font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Directory listing for ${pathname}</h1>
    </div>`;
        
        if (pathname !== '/') {
            html += `<div class="file folder"><a href="../">../</a></div>`;
        }
        
        files.forEach(file => {
            const filePath = path.join(dirPath, file);
            const stats = fs.statSync(filePath);
            const isDirectory = stats.isDirectory();
            const displayName = isDirectory ? `${file}/` : file;
            const cssClass = isDirectory ? 'folder' : 'file';
            
            html += `<div class="file ${cssClass}">
                <a href="${path.join(pathname, file)}">${displayName}</a>
                <span style="margin-left: 20px; color: #666; font-size: 0.9em;">
                    ${stats.mtime.toLocaleDateString()} ${stats.mtime.toLocaleTimeString()}
                    ${isDirectory ? '' : `(${formatBytes(stats.size)})`}
                </span>
            </div>`;
        });
        
        html += `</body></html>`;
        
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(html);
    });
}

// Handle API requests
function handleApiRequest(req, res, pathname) {
    const segments = pathname.split('/').filter(s => s);
    
    if (segments[1] === 'nvm') {
        handleNvmApi(req, res, segments.slice(2));
    } else if (segments[1] === 'ai') {
        handleAiApi(req, res, segments.slice(2));
    } else {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'API endpoint not found' }));
    }
}

// Handle NVM API
function handleNvmApi(req, res) {
    const response = {
        message: 'NVM API',
        version: '0.39.0',
        ai_enabled: process.env.NVM_AI_ENABLED === '1',
        endpoints: [
            '/api/nvm/version',
            '/api/nvm/list',
            '/api/nvm/current'
        ]
    };
    
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(response, null, 2));
}

// Handle AI API
function handleAiApi(req, res) {
    const response = {
        message: 'NVM AI Super Intelligence API',
        status: 'active',
        features: [
            'intelligent_recommendations',
            'security_scanning',
            'performance_optimization',
            'learning_analytics'
        ],
        endpoints: [
            '/api/ai/recommend',
            '/api/ai/analyze',
            '/api/ai/security'
        ]
    };
    
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(response, null, 2));
}

// Format bytes utility with safe size handling
function formatBytes(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    
    // Use explicit size mapping for security
    let size = 'Bytes';
    let sizeIndex = 0;
    
    if (i >= 3) {
        size = 'GB';
        sizeIndex = 3;
    } else if (i >= 2) {
        size = 'MB';
        sizeIndex = 2;
    } else if (i >= 1) {
        size = 'KB';
        sizeIndex = 1;
    }
    
    return parseFloat((bytes / Math.pow(k, sizeIndex)).toFixed(2)) + ' ' + size;
}

// Error handling
server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error(`Port ${PORT} is already in use. Please try a different port.`);
        process.exit(1);
    } else {
        console.error('Server error:', err);
    }
});

// Graceful shutdown
process.on('SIGTERM', () => {
    console.log('Received SIGTERM, shutting down gracefully');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('Received SIGINT, shutting down gracefully');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});

// Start server
server.listen(PORT, HOST, () => {
    console.log(`🚀 Server running at http://${HOST}:${PORT}/`);
    console.log(`📁 Serving files from: ${__dirname}`);
    console.log(`🕒 Started at: ${new Date().toISOString()}`);
    console.log(`📋 Available endpoints:`);
    console.log(`   - http://localhost:${PORT}/`);
    console.log(`   - http://localhost:${PORT}/api/nvm`);
    console.log(`   - http://localhost:${PORT}/api/ai`);
});
