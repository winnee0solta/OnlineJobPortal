@extends('dashboard.layout.base')

@section('content')


<div class="card">
    <div class="card-body">
        <h5 class="card-title">Employers Lists</h5>
    </div>
</div>


<div class="card table-responsive">
    <table class="table mb-0">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Created At</th>
                <th scope="col">Email</th>
                <th scope="col">Company Name</th>
                <th scope="col">Company Phone</th>
                <th scope="col">Company Address</th>
                <th scope="col">Map Data</th>
                <th scope="col">Verification Status</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>

            @if (!empty($employers))
            @foreach ($employers as $employer)
            <tr>
                <th scope="row">{{$loop->index +1}}</th>
                <td>{{  date( "m/d/Y", strtotime($employer['created_at']))  }}</td>
                <td>{{$employer['email']}}</td>
                <td>{{$employer['company_name']}}</td>
                <td>{{$employer['company_phone']}}</td>
                <td>{{$employer['company_address']}}</td>
                <td>Lat : 121 , Long : 12 </td>
                <td class="text-uppercase">
                    @if ($employer['isverified'])
                    <span class="mr-1">Verified</span>
                    <a href="/employers/{{$employer['employer_id']}}/unverify" class="btn btn-float btn-danger btn-sm" type="button"><i
                            class="material-icons">close</i></a>
                    @else
                    <span class="mr-1">NONE</span>
                    <a href="/employers/{{$employer['employer_id']}}/verify" class="btn btn-float btn-success btn-sm" type="button"><i
                            class="material-icons">check</i></a>
                    @endif
                </td>
                <td>
                    <a href="/employers/{{$employer['employer_id']}}/remove" class="btn btn-float btn-danger btn-sm " type="button"><i
                            class="material-icons">delete</i></a>
                </td>
            </tr>
            @endforeach
            @endif
        </tbody>
    </table>
</div>




@endsection
