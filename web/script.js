// AgroVision JavaScript Functions

// Navigation History
let navigationHistory = ['home-screen'];

// Screen Navigation
function showScreen(screenId) {
    // Get current screen
    const currentScreen = document.querySelector('.screen.active');
    const currentScreenId = currentScreen ? currentScreen.id : 'home-screen';
    
    // Add current screen to history if not already there
    if (navigationHistory[navigationHistory.length - 1] !== currentScreenId) {
        navigationHistory.push(currentScreenId);
    }
    
    // Add new screen to history
    navigationHistory.push(screenId);
    
    // Hide all screens
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => screen.classList.remove('active'));
    
    // Show target screen
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
    }
    
    // Update navigation
    updateNavigation(screenId);
    
    // Update back button visibility
    updateBackButton(screenId);
    
    // Initialize screen-specific features
    initializeScreen(screenId);
}

// Go Back Function
function goBack() {
    if (navigationHistory.length > 1) {
        // Remove current screen from history
        navigationHistory.pop();
        
        // Get previous screen
        const previousScreen = navigationHistory[navigationHistory.length - 1];
        
        // Navigate to previous screen without adding to history
        navigateToScreen(previousScreen);
    }
}

// Navigate without adding to history
function navigateToScreen(screenId) {
    // Hide all screens
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => screen.classList.remove('active'));
    
    // Show target screen
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
    }
    
    // Update navigation
    updateNavigation(screenId);
    
    // Update back button visibility
    updateBackButton(screenId);
    
    // Initialize screen-specific features
    initializeScreen(screenId);
}

// Update Back Button Visibility
function updateBackButton(screenId) {
    const backBtn = document.getElementById('back-btn');
    const mainScreens = ['home-screen', 'help', 'profile'];
    
    if (mainScreens.includes(screenId) || navigationHistory.length <= 1) {
        backBtn.style.display = 'none';
    } else {
        backBtn.style.display = 'flex';
    }
}

// Update Bottom Navigation
function updateNavigation(screenId) {
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => item.classList.remove('active'));
    
    // Map screens to nav items
    const navMapping = {
        'home-screen': 0,
        'help': 1,
        'profile': 2
    };
    
    if (navMapping.hasOwnProperty(screenId)) {
        navItems[navMapping[screenId]].classList.add('active');
    }
}

// Initialize Screen-Specific Features
function initializeScreen(screenId) {
    switch(screenId) {
        case 'crop-analysis-results':
            drawSoilChart();
            break;
        case 'yield-details':
            drawYieldChart();
            break;
        case 'chatbot':
            scrollChatToBottom();
            break;
    }
}

// Image Upload Simulation
function uploadImage() {
    // Simulate image upload process
    const uploadCard = document.querySelector('.upload-card');
    const originalContent = uploadCard.innerHTML;
    
    // Show loading state
    uploadCard.innerHTML = `
        <div style="padding: 48px 24px;">
            <i class="fas fa-spinner fa-spin" style="font-size: 48px; color: #4CAF50; margin-bottom: 16px;"></i>
            <h2 style="color: #2E7D32;">Processing Image...</h2>
            <p style="color: #666;">Please wait while we analyze your photo</p>
        </div>
    `;
    
    // Simulate processing time
    setTimeout(() => {
        showScreen('choose-analysis');
    }, 2000);
}

// Crop Selection Logic
const cropsByState = {
    'Punjab': ['Wheat', 'Rice', 'Cotton', 'Sugarcane', 'Maize'],
    'Maharashtra': ['Cotton', 'Sugarcane', 'Soybean', 'Wheat', 'Rice'],
    'Uttar Pradesh': ['Wheat', 'Rice', 'Sugarcane', 'Potato', 'Mustard'],
    'Haryana': ['Wheat', 'Rice', 'Cotton', 'Mustard', 'Barley']
};

function updateCrops() {
    const stateSelect = document.getElementById('state-select');
    const cropSelect = document.getElementById('crop-select');
    const selectedState = stateSelect.value;
    
    // Clear crop options
    cropSelect.innerHTML = '<option value="">Select a crop</option>';
    
    if (selectedState && cropsByState[selectedState]) {
        cropsByState[selectedState].forEach(crop => {
            const option = document.createElement('option');
            option.value = crop;
            option.textContent = crop;
            cropSelect.appendChild(option);
        });
        cropSelect.disabled = false;
    } else {
        cropSelect.disabled = true;
    }
    
    // Update selected info
    updateSelectedInfo();
}

function updateSelectedInfo() {
    const stateSelect = document.getElementById('state-select');
    const cropSelect = document.getElementById('crop-select');
    const selectedInfo = document.getElementById('selected-info');
    const selectedState = document.getElementById('selected-state');
    const selectedCrop = document.getElementById('selected-crop');
    
    if (stateSelect.value || cropSelect.value) {
        selectedInfo.style.display = 'block';
        selectedState.textContent = `Selected Region: ${stateSelect.value || 'None'}`;
        selectedCrop.textContent = `Selected Crop: ${cropSelect.value || 'None'}`;
    } else {
        selectedInfo.style.display = 'none';
    }
}

function showYieldDetails() {
    const stateSelect = document.getElementById('state-select');
    const cropSelect = document.getElementById('crop-select');
    
    if (!stateSelect.value || !cropSelect.value) {
        alert('Please select both state and crop');
        return;
    }
    
    // Update yield details screen
    document.getElementById('crop-name').textContent = cropSelect.value;
    document.getElementById('crop-state').textContent = stateSelect.value;
    
    showScreen('yield-details');
}

// Chat Functionality
function sendMessage() {
    const input = document.getElementById('chat-input-field');
    const message = input.value.trim();
    
    if (!message) return;
    
    // Add user message
    addMessage(message, 'user');
    input.value = '';
    
    // Simulate bot response
    setTimeout(() => {
        const botResponse = generateBotResponse(message);
        addMessage(botResponse, 'bot');
    }, 1000);
}

function handleChatInput(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

function addMessage(text, sender) {
    const messagesContainer = document.getElementById('chat-messages');
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${sender}-message`;
    
    const avatar = sender === 'bot' ? '🤖' : '👨‍🌾';
    
    messageDiv.innerHTML = `
        <div class="message-avatar">${avatar}</div>
        <div class="message-content">${text}</div>
    `;
    
    messagesContainer.appendChild(messageDiv);
    scrollChatToBottom();
}

function scrollChatToBottom() {
    const messagesContainer = document.getElementById('chat-messages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function generateBotResponse(userMessage) {
    const responses = {
        'disease': 'Common crop diseases include blight, rust, and powdery mildew. For accurate diagnosis, please use our crop analysis feature with a clear photo of the affected plant.',
        'pest': 'Integrated Pest Management (IPM) is the best approach. This includes biological control, crop rotation, and targeted pesticide use only when necessary.',
        'soil': 'Soil health depends on pH, organic matter, and nutrient levels. Regular soil testing every 2-3 years helps maintain optimal growing conditions.',
        'weather': 'Weather monitoring is crucial for farming decisions. Check our weather forecasts and consider drought-resistant varieties during dry seasons.',
        'fertilizer': 'Use soil test results to determine fertilizer needs. Organic options like compost improve soil structure, while chemical fertilizers provide quick nutrient release.',
        'water': 'Efficient irrigation saves water and improves yields. Drip irrigation and mulching help retain soil moisture and reduce water usage.',
        'yield': 'Yield improvement comes from good seed quality, proper spacing, timely fertilization, pest control, and adequate water management.',
        'crop rotation': 'Crop rotation prevents soil depletion and reduces pest buildup. Alternate between nitrogen-fixing legumes and heavy feeders like corn or wheat.'
    };
    
    const lowerMessage = userMessage.toLowerCase();
    
    for (const [key, response] of Object.entries(responses)) {
        if (lowerMessage.includes(key)) {
            return response;
        }
    }
    
    return "That's a great question! I can help you with crop diseases, pest management, soil health, weather patterns, fertilizers, irrigation, and yield improvement. What specific topic would you like to know more about?";
}

// Chart Drawing Functions
function drawSoilChart() {
    const canvas = document.getElementById('soilChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const width = canvas.width;
    const height = canvas.height;
    
    // Clear canvas
    ctx.clearRect(0, 0, width, height);
    
    // Sample soil data
    const data = [
        { label: 'pH Level', value: 6.8, max: 14, color: '#4CAF50' },
        { label: 'Nitrogen', value: 75, max: 100, color: '#2196F3' },
        { label: 'Phosphorus', value: 60, max: 100, color: '#FF9800' },
        { label: 'Potassium', value: 85, max: 100, color: '#9C27B0' }
    ];
    
    const barHeight = 30;
    const barSpacing = 40;
    const startY = 30;
    
    data.forEach((item, index) => {
        const y = startY + (index * barSpacing);
        const barWidth = (item.value / item.max) * (width - 120);
        
        // Draw background bar
        ctx.fillStyle = '#f0f0f0';
        ctx.fillRect(80, y, width - 120, barHeight);
        
        // Draw value bar
        ctx.fillStyle = item.color;
        ctx.fillRect(80, y, barWidth, barHeight);
        
        // Draw label
        ctx.fillStyle = '#333';
        ctx.font = '12px Inter';
        ctx.textAlign = 'right';
        ctx.fillText(item.label, 75, y + 20);
        
        // Draw value
        ctx.textAlign = 'left';
        ctx.fillText(item.value + (item.label === 'pH Level' ? '' : '%'), barWidth + 85, y + 20);
    });
}

function drawYieldChart() {
    const canvas = document.getElementById('yieldChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const width = canvas.width;
    const height = canvas.height;
    
    // Clear canvas
    ctx.clearRect(0, 0, width, height);
    
    // Sample yield data (tonnes per hectare)
    const historicalData = [2.1, 2.3, 2.8, 2.5, 3.0, 2.9, 3.2, 3.1, 3.4, 3.2];
    const predictedData = [3.5, 3.7, 3.6, 3.8, 4.0];
    const years = ['2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029'];
    
    const padding = 40;
    const chartWidth = width - (padding * 2);
    const chartHeight = height - (padding * 2);
    
    // Find min/max values
    const allData = [...historicalData, ...predictedData];
    const minValue = Math.min(...allData) * 0.8;
    const maxValue = Math.max(...allData) * 1.1;
    
    // Draw axes
    ctx.strokeStyle = '#ddd';
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(padding, padding);
    ctx.lineTo(padding, height - padding);
    ctx.lineTo(width - padding, height - padding);
    ctx.stroke();
    
    // Draw historical data
    ctx.strokeStyle = '#4CAF50';
    ctx.lineWidth = 3;
    ctx.beginPath();
    
    historicalData.forEach((value, index) => {
        const x = padding + (index * (chartWidth / (years.length - 1)));
        const y = height - padding - ((value - minValue) / (maxValue - minValue)) * chartHeight;
        
        if (index === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
        
        // Draw data points
        ctx.fillStyle = '#4CAF50';
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, 2 * Math.PI);
        ctx.fill();
    });
    ctx.stroke();
    
    // Draw predicted data
    ctx.strokeStyle = '#2196F3';
    ctx.setLineDash([5, 5]);
    ctx.beginPath();
    
    const allYieldData = [...historicalData, ...predictedData];
    predictedData.forEach((value, index) => {
        const dataIndex = historicalData.length + index;
        const x = padding + (dataIndex * (chartWidth / (years.length - 1)));
        const y = height - padding - ((value - minValue) / (maxValue - minValue)) * chartHeight;
        
        if (index === 0) {
            // Connect to last historical point
            const lastHistoricalX = padding + ((historicalData.length - 1) * (chartWidth / (years.length - 1)));
            const lastHistoricalY = height - padding - ((historicalData[historicalData.length - 1] - minValue) / (maxValue - minValue)) * chartHeight;
            ctx.moveTo(lastHistoricalX, lastHistoricalY);
            ctx.lineTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
        
        // Draw data points
        ctx.fillStyle = '#2196F3';
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, 2 * Math.PI);
        ctx.fill();
    });
    ctx.stroke();
    ctx.setLineDash([]);
    
    // Draw year labels (every 3 years)
    ctx.fillStyle = '#666';
    ctx.font = '10px Inter';
    ctx.textAlign = 'center';
    years.forEach((year, index) => {
        if (index % 3 === 0) {
            const x = padding + (index * (chartWidth / (years.length - 1)));
            ctx.fillText(year, x, height - padding + 15);
        }
    });
}

// Analysis Report Functions
function viewAnalysisReport(reportId) {
    // Load report data based on ID
    loadReportData(reportId);
    
    // Navigate to analysis report screen
    showScreen('analysis-report');
}

function loadReportData(reportId) {
    // Sample report data - in a real app, this would come from a database
    const reportData = {
        'wheat-disease-001': {
            title: 'Wheat Disease Analysis Report',
            date: 'June 24, 2025',
            id: 'WH-001',
            cropType: 'Wheat',
            location: 'Punjab, India',
            growthStage: 'Flowering',
            fieldSize: '2.5 acres',
            resultTitle: 'Minor Pest Risk Detected',
            resultConfidence: 'Confidence: 87%',
            severity: 'Low Risk',
            resultDetails: 'Analysis indicates early signs of aphid presence on wheat leaves. Current infestation level is low but requires monitoring to prevent spread.',
            temperature: '18°C - 32°C',
            humidity: '65%',
            visibility: '10 km',
            wind: '12 km/h'
        },
        'rice-soil-002': {
            title: 'Rice Soil Health Analysis Report',
            date: 'June 21, 2025',
            id: 'RC-002',
            cropType: 'Rice',
            location: 'Punjab, India',
            growthStage: 'Vegetative',
            fieldSize: '3.2 acres',
            resultTitle: 'Good Soil Condition',
            resultConfidence: 'Confidence: 92%',
            severity: 'Optimal',
            resultDetails: 'Soil analysis shows excellent pH balance and good nutrient levels. Nitrogen and potassium levels are within optimal ranges for rice cultivation.',
            temperature: '22°C - 35°C',
            humidity: '72%',
            visibility: '8 km',
            wind: '8 km/h'
        }
    };
    
    const data = reportData[reportId] || reportData['wheat-disease-001'];
    
    // Update report content
    document.getElementById('report-title').textContent = data.title;
    document.getElementById('report-date').textContent = data.date;
    document.getElementById('report-id').textContent = data.id;
    document.getElementById('report-crop-type').textContent = data.cropType;
    document.getElementById('report-location').textContent = data.location;
    document.getElementById('report-growth-stage').textContent = data.growthStage;
    document.getElementById('report-field-size').textContent = data.fieldSize;
    document.getElementById('result-title').textContent = data.resultTitle;
    document.getElementById('result-confidence').textContent = data.resultConfidence;
    document.getElementById('severity-badge').innerHTML = `<span>${data.severity}</span>`;
    document.getElementById('result-details').innerHTML = `<p>${data.resultDetails}</p>`;
    document.getElementById('report-temperature').textContent = data.temperature;
    document.getElementById('report-humidity').textContent = data.humidity;
    document.getElementById('report-visibility').textContent = data.visibility;
    document.getElementById('report-wind').textContent = data.wind;
    
    // Update severity badge color based on severity
    const severityBadge = document.getElementById('severity-badge');
    const resultIcon = document.querySelector('.result-icon i');
    
    if (data.severity === 'Low Risk' || data.severity === 'Optimal') {
        severityBadge.style.background = '#E8F5E8';
        severityBadge.style.color = '#2E7D32';
        resultIcon.className = 'fas fa-check-circle';
        resultIcon.style.color = '#4CAF50';
    } else if (data.severity === 'Medium Risk') {
        severityBadge.style.background = '#FFF3E0';
        severityBadge.style.color = '#F57C00';
        resultIcon.className = 'fas fa-exclamation-triangle';
        resultIcon.style.color = '#FF9800';
    } else {
        severityBadge.style.background = '#FFEBEE';
        severityBadge.style.color = '#C62828';
        resultIcon.className = 'fas fa-exclamation-circle';
        resultIcon.style.color = '#F44336';
    }
}

// Help Screen Functions
function showAboutUs() {
    alert('AgroVision is a comprehensive agriculture assistant app designed to help farmers improve their crop yields through AI-powered analysis and expert guidance.');
}

function showReportIssue() {
    alert('To report an issue, please contact our support team at support@agrovision.com or call 1-800-AGRO-HELP.');
}

function showTerms() {
    alert('Terms and Conditions: By using AgroVision, you agree to our terms of service. For full terms, visit our website at www.agrovision.com/terms');
}

// Initialize App
document.addEventListener('DOMContentLoaded', function() {
    // Set up event listeners
    const stateSelect = document.getElementById('state-select');
    const cropSelect = document.getElementById('crop-select');
    
    if (stateSelect) {
        stateSelect.addEventListener('change', updateCrops);
    }
    
    if (cropSelect) {
        cropSelect.addEventListener('change', updateSelectedInfo);
    }
    
    // Initialize charts if on relevant screens
    const currentScreen = document.querySelector('.screen.active');
    if (currentScreen) {
        initializeScreen(currentScreen.id);
    }
    
    // Initialize back button state
    updateBackButton('home-screen');
});

// Weather Data Update (simulated)
function updateWeatherData() {
    const weatherConditions = ['Sunny', 'Cloudy', 'Partly Cloudy', 'Light Rain'];
    const temperatures = [22, 25, 28, 31, 26, 23];
    
    const condition = weatherConditions[Math.floor(Math.random() * weatherConditions.length)];
    const temp = temperatures[Math.floor(Math.random() * temperatures.length)];
    
    const weatherCard = document.querySelector('.weather-card');
    if (weatherCard) {
        const weatherDetails = weatherCard.querySelector('.weather-details p');
        const temperature = weatherCard.querySelector('.temperature');
        
        if (weatherDetails) weatherDetails.textContent = condition;
        if (temperature) temperature.textContent = temp + '°C';
    }
}

// Auto-update weather every 5 minutes
setInterval(updateWeatherData, 300000);

// Image placeholder click handler
document.addEventListener('click', function(e) {
    if (e.target.closest('.placeholder-image')) {
        uploadImage();
    }
});