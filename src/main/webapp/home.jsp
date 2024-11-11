<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Landing Page</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card {
            width: 45%;
        }
        .arrow-icon {
            cursor: pointer;
        }
        .about-section {
            background-color: #f8f9fa;
            padding: 50px 0;
        }
        .about-section h2 {
            margin-bottom: 30px;
        }
        .about-section p {
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    
    <nav class="navbar bg-body-secondary">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="resource/logo_swasth.jpg" alt="Logo" width="60" height="60" class="me-2">
                <span>Swasth Saarthi</span>
            </a>
        </div>
    </nav>
    
    <div class="container mt-5">
        <div class="row justify-content-around mt-5">
            
            <!-- First Card (User) -->
            <div class="card d-flex flex-row p-3">
                <img src="resource/userLogo.avif" alt="User Image" class="img-fluid rounded-circle me-3" width="100" height="100">
                <div>
                    <h2 class="card-title">Resident</h2>
                    <a href="resident/residentLogin.jsp">
                        <svg xmlns="userLogo.avif" width="24" height="24" fill="currentColor" class="bi bi-arrow-right-circle arrow-icon" viewBox="0 0 16 16">
                          <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
                          <path fill-rule="evenodd" d="M8.5 5.5a.5.5 0 0 1 .5.5v3h2a.5.5 0 0 1 0 1h-2v2a.5.5 0 0 1-1 0v-2H5.5a.5.5 0 0 1 0-1H8v-3a.5.5 0 0 1 .5-.5z"/>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Second Card (Health Worker) -->
            <div class="card d-flex flex-row p-3">
                <img src="resource/userLogo.avif" alt="Health Worker Image" class="img-fluid rounded-circle me-3" width="100" height="100">
                <div>
                    <h2 class="card-title">Health Worker</h2>
                    <!-- Arrow Icon -->
                    <a href="healthworker/healthWorkerLogin.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-right-circle arrow-icon" viewBox="0 0 16 16">
                          <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
                          <path fill-rule="evenodd" d="M8.5 5.5a.5.5 0 0 1 .5.5v3h2a.5.5 0 0 1 0 1h-2v2a.5.5 0 0 1-1 0v-2H5.5a.5.5 0 0 1 0-1H8v-3a.5.5 0 0 1 .5-.5z"/>
                        </svg>
                    </a>
                </div>
            </div>
            
        </div>
    </div>

    <!-- About Section -->
    <section class="about-section mt-5">
        <div class="container">
            <h2 class="text-center">About Swasth Saarthi</h2>
            <p class="text-center">Swasth Saarthi is an initiative aimed at raising health awareness in rural areas. We believe that every individual, regardless of location, deserves access to critical healthcare information and resources. Our platform connects residents with local health workers, offering vital services like health education, appointment scheduling, and community support.</p>
            <div class="row mt-4">
                <div class="col-md-6">
                    <h5>Our Mission</h5>
                    <p>To empower rural communities by providing them with the knowledge and tools they need to maintain their health and well-being. Through a network of dedicated health workers and a user-friendly platform, we aim to bridge the gap in healthcare services.</p>
                </div>
                <div class="col-md-6">
                    <h5>Why Choose Swasth Saarthi?</h5>
                    <p>We offer easy access to reliable health information and services, promote preventive healthcare measures, and foster a community-driven approach to well-being. Our platform ensures that rural populations are connected with healthcare professionals who understand their unique needs.</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>