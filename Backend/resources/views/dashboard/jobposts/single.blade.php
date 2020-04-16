@extends('dashboard.layout.base')

@section('content')

<div class="card">
    <div class="card-body">
        <h5 class="h5 font-weight-bold">Job Post | {{$post['jobtitle']}}</h5>
    </div>
</div>

<div class="row justify-content-center mb-5">
    <div class="col-12 col-md-6">
        <div class="card mt-4">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table mb-0">
                        <tbody>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Posted At
                                    </span>
                                </td>
                                <td>
                                    {{  date( "m/d/Y", strtotime($post['created_at']))  }}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">Admin Post</span>
                                </td>
                                <td>
                                    @if ($post['admin_post'])
                                    YES
                                    @else
                                    NO
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Company Name
                                    </span>
                                </td>
                                <td>
                                    {{ $post['company_name'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Company Address
                                    </span>
                                </td>
                                <td>
                                    {{ $post['company_address'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Company Phone
                                    </span>
                                </td>
                                <td>
                                    {{ $post['company_phone'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Job Title
                                    </span>
                                </td>
                                <td>
                                    {{ $post['jobtitle'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Job Type
                                    </span>
                                </td>
                                <td>
                                    {{ $post['jobtype'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        designation
                                    </span>
                                </td>
                                <td>
                                    {{ $post['designation'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        qualification
                                    </span>
                                </td>
                                <td>
                                    {{ $post['qualification'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        specialization
                                    </span>
                                </td>
                                <td>
                                    {{ $post['specialization'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        skills
                                    </span>
                                </td>
                                <td>
                                    {{ $post['skills'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        Deadline
                                    </span>
                                </td>
                                <td>
                                    {{ $post['lastdate'] }}

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="font-weight-bold text-uppercase">
                                        description
                                    </span>
                                </td>
                                <td>
                                    {{ $post['desc'] }}

                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>








@endsection
