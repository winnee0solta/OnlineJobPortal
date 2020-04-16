<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Online Job Portal</title>

    <!-- CSS -->
    <!-- Add Material font (Roboto) and Material icon as needed -->
    <link
        href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i|Roboto+Mono:300,400,700|Roboto+Slab:300,400,700"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <link rel="stylesheet" href="{{asset('/css/app.css')}}">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="{{asset('/js/app.js')}}"></script>
</head>

<body>




    <header class="navbar navbar-dark navbar-full bg-primary doc-navbar-default">
        <button id="drawer_switcher" aria-controls="navdrawerDefault" aria-expanded="false"
            aria-label="Toggle Navdrawer" class="navbar-toggler" data-target="#navdrawerDefault"
            data-toggle="navdrawer"><span class="navbar-toggler-icon"></span></button>
        <span class="navbar-brand mr-auto">Online Job Portal</span>
        <div>
            <a href="/logout" class="text-white"><i class="material-icons mr-3">logout</i></a>
        </div>
    </header>

    <div aria-hidden="true" class="navdrawer" id="navdrawerDefault" tabindex="-1">
        <div class="navdrawer-content">

            <nav class="navdrawer-nav">
                <a class="nav-item nav-link" href="/dashboard">
                    {{-- <i class="material-icons mr-3">dashboard</i> --}}
                    Dashboard
                </a>
                <a class="nav-item nav-link" href="/job-posts">
                    Job Posts
                </a>
                <a class="nav-item nav-link" href="/employers">
                    Employers
                </a>
                <a class="nav-item nav-link" href="/jobseekers">
                    Jobseekers
                </a>

            </nav>
            <div class="navdrawer-divider"></div>

        </div>
    </div>
    {{-- <main class="layout-content"> --}}
    <div class="container-fluid mt-3">

        @yield('content')
    </div>
    {{-- </main> --}}






    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

    <script src="{{asset('/js/app.js')}}"></script>
</body>

</html>
