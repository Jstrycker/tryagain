<h1>List of rides</h1>

<p><%= pluralize(@rides.count, 'ride') %></p>
<ol><%= @rides.each do |r|   %>
	    <li>
	<% @user=r.user %>
`<h1>Profile Page for <%= @user.name %>'s ride<h1>
<p>Name: <%=@user.name%></p>
<p>Email: <%= @user.email %></p>
<p> Date:    <%= r.date %></p>
    <p> Departs at:<%= r.leave_time %></p>
    <p> Returns at <%= r.return_time %></p>

   <p> <%= r.number_of_seats %></p>

 <p>  <%= r.meeting_location %></p>
   <p> <%= r.vehicle %></p>

</li>
<%end%>
</ol>
