@extends('dashboard.layout.base')

@section('content')

@if (!empty($employers))
@foreach ($employers as $employer)

@endforeach
@endif

<div class="card">
    <div class="card-body">
        <h5 class="card-title">Jobseekers Lists</h5>
    </div>
</div>


<div class="card table-responsive">
    <table class="table mb-0">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Created At</th>
                <th scope="col">Email</th>
                <th scope="col">Fullname</th>
                <th scope="col">Phone</th>
                <th scope="col">Address</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>

            @if (!empty($jobseekers))
            @foreach ($jobseekers as $item)
            <tr>
                <th scope="row">{{$loop->index +1}}</th>
                <td>{{  date( "m/d/Y", strtotime($item['created_at']))  }}</td>
                <td>{{$item['email']}}</td>
                <td>{{$item['fullname']}}</td>
                <td>{{$item['phone_no']}}</td>
                <td>{{$item['address']}}</td>
                <td>
                    <a href="/jobseekers/{{$item['jobseekers_id']}}/remove" class="btn btn-float btn-danger btn-sm " type="button"><i
                            class="material-icons">delete</i></a>
                </td>
            </tr>
            @endforeach
            @endif
        </tbody>
    </table>
</div>




@endsection
