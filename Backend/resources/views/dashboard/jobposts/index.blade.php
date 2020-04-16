@extends('dashboard.layout.base')

@section('content')


<div class="mb-3">
    <a href="/job-posts/add" class="btn btn-primary">Post New Job</a>
</div>



<div class="card">
    <div class="card-body">
        <h5 class="card-title">Job Posts</h5>
    </div>
</div>


<div class="card table-responsive">
    <table class="table mb-0">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Created At</th>
                <th scope="col">By Admin</th>
                <th scope="col">Company Name</th>
                <th scope="col">Title</th>
                <th scope="col">Type</th>
                <th scope="col">Designation</th>
                <th scope="col">Qualificaiton</th>
                <th scope="col">Deadline</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>

            @if (!empty($posts))
            @foreach ($posts as $item)
            <tr>
                <th scope="row">{{$loop->index +1}}</th>
                <td>{{  date( "m/d/Y", strtotime($item['created_at']))  }}</td>
                <td>
                    @if ($item['admin_post'])

                    <button class="btn  btn-flat-success btn-success btn-sm" type="button"><i
                            class="material-icons">check</i></button>
                    @else
                    <button class="btn  btn-flat-danger btn-danger btn-sm" type="button"><i
                            class="material-icons">close</i></button>
                    @endif
                </td>
                <td>{{$item['company_name']}}</td>
                <td>{{$item['jobtitle']}}</td>
                <td>{{$item['jobtype']}}</td>
                <td>{{$item['designation']}}</td>
                <td>{{$item['qualification']}}</td>
                <td>{{$item['lastdate']}}</td>

                <td>
                    <div class="d-flex">
                        <a href="/job-posts/{{$item['post_id']}}/view" class="btn btn-float btn-success btn-sm "
                            type="button"><i class="material-icons">visibility</i></a>
                        <a href="/job-posts/{{$item['post_id']}}/edit" class="btn btn-float btn-dark btn-sm ml-1"
                            type="button"><i class="material-icons">edit</i></a>
                        <a href="/job-posts/{{$item['post_id']}}/remove" class="btn btn-float btn-danger btn-sm ml-1 "
                            type="button"><i class="material-icons">delete</i></a>
                    </div>
                </td>
            </tr>
            @endforeach
            @endif
        </tbody>
    </table>
</div>



@endsection
