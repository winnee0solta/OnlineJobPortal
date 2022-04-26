@extends('dashboard.layout.base')

@section('content')


<div class="mb-3">
    <button class="btn btn-primary" data-toggle="modal" data-target="#addJobPostModal">
        Post New Job
    </button>
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
                        <button class="btn btn-float btn-dark btn-sm ml-1" data-toggle="modal"
                            data-target="#editJobPostModal-{{$item['post_id']}}" type="button"><i
                                class="material-icons">edit</i></button>
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


@section('modal')

<div class="modal fade" id="addJobPostModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Job Post</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form action="/job-posts/add" method="POST">
                    {{ csrf_field() }}

                    <div class="form-group">
                        <label>Company Name</label>
                        <input name="company_name" required type="text" class="form-control"
                            placeholder="Enter company phone">
                    </div>
                    <div class="form-group">
                        <label>Company Address</label>
                        <input name="company_address" required type="text" class="form-control"
                            placeholder="Enter company address">
                    </div>
                    <div class="form-group">
                        <label>Company Phone</label>
                        <input name="company_phone" required type="text" class="form-control"
                            placeholder="Enter company phone">
                    </div>
                    <div class="form-group">
                        <label>Job Title</label>
                        <input name="jobtitle" required type="text" class="form-control" placeholder="Enter job title">
                    </div>
                    <div class="form-group">
                        <label>Job Type</label>
                        <input name="jobtype" required type="text" class="form-control" placeholder="Enter job type">
                    </div>
                    <div class="form-group">
                        <label>Job Designation</label>
                        <input name="designation" required type="text" class="form-control"
                            placeholder="Enter Designation">
                    </div>
                    <div class="form-group">
                        <label>Qualification</label>
                        <input name="qualification" required type="text" class="form-control"
                            placeholder="Enter qualification">
                    </div>
                    <div class="form-group">
                        <label>Specialization</label>
                        <input name="specialization" required type="text" class="form-control"
                            placeholder="Enter specialization">
                    </div>
                    <div class="form-group">
                        <label>Skills</label>
                        <input name="skills" required type="text" class="form-control" placeholder="Enter skills">
                    </div>
                    <div class="form-group">
                        <label>Deadline</label>
                        <input name="lastdate" required type="date" class="form-control" placeholder="Enter deadline">
                    </div>
                    <div class="form-group">
                        <label>Job Description</label>
                        <textarea name="desc" required type="text" class="form-control"
                            placeholder="Enter job description" rows="5"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Add Job Post</button>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


@if (!empty($posts))
@foreach ($posts as $item)

<div class="modal fade" id="editJobPostModal-{{$item['post_id']}}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Job Post</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form action="/job-posts/{{$item['post_id']}}/edit" method="POST">
                    {{ csrf_field() }}

                    @if ($item['admin_post'])
                    <div class="form-group">
                        <label>Company Name</label>
                        <input name="company_name" required type="text" class="form-control"
                            placeholder="Enter company phone" value="{{$item['company_name']}}">
                    </div>
                    <div class="form-group">
                        <label>Company Address</label>
                        <input name="company_address" required type="text" class="form-control"
                            placeholder="Enter company address" value="{{$item['company_address']}}">
                    </div>
                    <div class="form-group">
                        <label>Company Phone</label>
                        <input name="company_phone" required type="text" class="form-control"
                            placeholder="Enter company phone" value="{{$item['company_phone']}}">
                    </div>
                    @endif
                    <div class="form-group">
                        <label>Job Title</label>
                        <input name="jobtitle" required type="text" class="form-control" placeholder="Enter job title"
                            value="{{$item['jobtitle']}}">
                    </div>
                    <div class="form-group">
                        <label>Job Type</label>
                        <input name="jobtype" required type="text" class="form-control" placeholder="Enter job type"
                            value="{{$item['jobtype']}}">
                    </div>
                    <div class="form-group">
                        <label>Job Designation</label>
                        <input name="designation" required type="text" class="form-control"
                            placeholder="Enter Designation" value="{{$item['designation']}}">
                    </div>
                    <div class="form-group">
                        <label>Qualification</label>
                        <input name="qualification" required type="text" class="form-control"
                            placeholder="Enter qualification" value="{{$item['qualification']}}">
                    </div>
                    <div class="form-group">
                        <label>Specialization</label>
                        <input name="specialization" required type="text" class="form-control"
                            placeholder="Enter specialization" value="{{$item['specialization']}}">
                    </div>
                    <div class="form-group">
                        <label>Skills</label>
                        <input name="skills" required type="text" class="form-control" placeholder="Enter skills"
                            value="{{$item['skills']}}">
                    </div>
                    <div class="form-group">
                        <label>Deadline</label>
                        <input name="lastdate" required type="date" class="form-control" placeholder="Enter deadline"
                            value="{{$item['lastdate']}}">
                    </div>
                    <div class="form-group">
                        <label>Job Description</label>
                        <textarea name="desc" required type="text" class="form-control"
                            placeholder="Enter job description" rows="5">{{$item['desc']}}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Job Post</button>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
@endforeach
@endif
@endsection
