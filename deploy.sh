#!/bin/bash
set -e
APP_DIR="/home/jm2594/app/Python-Azure-Actions"
echo "======================================"
echo "Starting Deployment..."
echo "======================================"
cd $APP_DIR
echo "Pulling latest source..."
git pull origin main
echo "Checking virtual environment..."
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi
source venv/bin/activate
echo "Upgrading pip..."
python3 -m pip install --upgrade pip
echo "Installing dependencies..."
python3 -m pip install -r requirements.txt
echo "Reloading systemd..."
sudo systemctl daemon-reload
echo "Restarting Flask service..."
sudo systemctl restart flask
echo "Waiting for service..."
sleep 5
echo "Checking service status..."
sudo systemctl status flask --no-pager
echo "Running health check..."
curl --fail http://localhost/health
echo ""
echo "Deployment Successful!"
echo "======================================"
