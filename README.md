# Emergency Response System  
**A Smart Governmental Emergency Response System for Citizens and Emergency Units**  


## 📖 Overview  
A comprehensive emergency management solution that:  
- Automatically identifies emergency type (Ambulance/Fire/Police)  
- Dispatches requests to nearest available emergency teams  
- Provides real-time tracking and multi-platform management  
- Supports text/voice reporting with AI-powered processing  

## ✨ System Components  
| Component | Description | Technology |
|-----------|-------------|------------|
| Citizen App | Emergency reporting & complaint management | Flutter |
| Emergency Team App | Request handling & live tracking | Flutter |
| Control Room Dashboard | Dispatch management & monitoring | Laravel |
| Supervisor Dashboard | Regional oversight & analytics | Bootstrap/Laravel |

## 📱 Citizen App Features  

### Key Functionalities:  
- 🚨 **Multi-mode Reporting**: Text input & voice-to-text conversion  
- 📍 **Auto-location Detection**: GPS integration with manual override  
- 📝 **Complaint System**: Track status with real-time updates  
- 🔒 **Secure Auth**: OTP verification + JWT sessions  
- 📚 **History Tracking**: All requests & responses archive  

## 🚨 Emergency Team App Features  

### Key Functionalities:  
- 🗺️ Live Incident Mapping: Real-time Google Maps integration  
- ⚡ Availability Toggle: Instant status updates  
- 🆘 Support Requests: Backup dispatch functionality  
- ❌ False Alarm Reporting: With evidence capture  
- 📊 Performance Analytics: Response time metrics  
## 🖥️ Control Room   

**Key Features:**  
- Proximity-based team prioritization  
- Automatic request redistribution  
- Live response tracking  
- Historical data analysis  

## 🖥️ Admin Dashboards  
### Supervisor Dashboard  
**Key Features:**  
- 🏢 Regional Center Management  
- 👥 Team Allocation System  
- 📅 Time-based Request Analytics  
- 📜 Complaint Resolution Center  

## 🛠️ Technology Stack  

| Layer | Technologies |
|-------|--------------|
| **Frontend** | Flutter 3.0, Bootstrap 5, Mapbox GL JS |
| **Backend** | Laravel 10, PHP 8.2, Laravel Sanctum |
| **Database** | MySQL 8.0, Redis Cache |
| **AI/ML** | TensorFlow NLP, Google Speech-to-Text |
| **Services** | Google Maps API, Twilio SMS, Firebase Cloud Messaging |

## 🚀 Installation Guide  

### Backend Setup  
```bash
# Clone & Configure
git clone https://github.com/gov-emergency/response-system.git
cd response-system/backend
cp .env.example .env 

# Install & Run
composer install
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

### Mobile Apps Setup  
```bash
# Citizen App
cd mobile/citizen_app
flutter pub get
flutter run -d chrome

# Emergency Team App 
cd mobile/team_app
flutter pub get
flutter run -d chrome
```

## 📜 License  
**Proprietary License**  
Copyright © 2025 [Obay Mosa]. All rights reserved.  

> 📢 **Usage Restrictions:**  
> - Usage is allowed for personal and governmental purposes only.  
> - Unauthorized copying, distribution, or modification of this software is prohibited.  
> -  No liability is accepted for damages caused by using this software.  

## 📞 Contact  
📧 [abymwsy1@gmail.com](mailto:abymwsy1@gmail.com)  
🌐 [Ob3y1](https://github.com/Ob3y1)  


