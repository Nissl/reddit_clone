1. What's the difference between rendering and redirecting? What's the impact with regards to instance variables, view templates?
<br/><br/>
Redirecting hits a new route, presumably triggering a new action that renders a specified template. Instance variables are discarded. 

Rendering loads a specified view. Instance variables we set up within an action are still available. This is an important distinction if we want to display validation errors, as they are attached by Rails to the objects which we are working with as instance variables at the controller level. We can then put code in the rendered view (or form partials that it in turn renders) that parses and displays the errors.

2. If I need to display a message on the view template, and I'm redirecting, what's the easiest way to accomplish this?
<br/><br/>
You generally want to use flash[:notice] or flash[:error], which in turn are rendered via application.html.erb > _messages.html.erb.

3. If I need to display a message on the view template, and I'm rendering, what's the easiest way to accomplish this?
<br/><br/>
You can either use flash[:notice] or flash[:error], or if there are errors attached to an object (or other information of interest associated with that object) you can set up your template to display the errors, as discussed in question #1.

4. Explain how we should save passwords to the database.
<br/><br/>
You should store them in the users table in encrypted form in a "password_digest" column. The encryption is carried out by a gem known as bcrypt-ruby, which implements the bcrypt algorithm, the latest and greatest in one-way hashing algorithms (with adjustable slowness, a big plus given ever-increasing computer speeds!) The gem adds a salt to the password (which is also stored in the digest) prior to running the algorithm to protect against rainbow table attacks. 

You can also use gems like Devise to manage all of your authentication, but this really limits your options and so we did not learn to do it in this course.

5. What should we do if we have a method that is used in both controllers and views?
<br/><br/>
We should put it in helpers/application_helper.rb, although apparently sometimes we should also put it in app/controllers/application_controller.rb, and started that file with the code helper_method :method_used_in_both_controllers_and_views to make it available outside the controllers. I will admit I'm not sure when we would do one versus the other, and I intend to ask about that in class tomorrow.

6. What is memoization? How is it a performance optimization?
<br/><br/>
Memoization is a coding pattern that is designed to avoid hitting the database to find the same bit of information multiple times in a single template. (You always need to hit it once per template, though!) It is most often coded as information_present ||= database_query. If information_present is not already loaded, then it performs the database_query and stores it as information_present.

7. If we want to prevent unauthenticated users from creating a new comment on a post, what should we do?
<br/><br/>
In the application controller, create a method, logged_in?, that returns true if session[:user_id]. (In our case, we did this via a third method, current_user). Then we create another method, require_user, that flashes an error and redirects unless logged_in? is true. Then, in the comments controller, we should add the line: require_user :create before our methods. This locks down the create action unless a user is present. We should also lock down the new comment form in our views by placing it inside of a (if logged_in?...end) statement.

8. Suppose we have the following table for tracking "likes" in our application. How can we make this table polymorphic? Note that the "user_id" foreign key is tracking who created the like.
<br/><br/>
You want to compress photo_id, video_id, and post_id into likeable_type and likeable_id. The numbers 12, 3, and 6 in the above table would go in the likeable_id column, while the type (Photo, Video, Post) would go in the likeable_type column.

9. How do we set up polymorphic associations at the model layer? Give example for the polymorphic model (eg, Vote) as well as an example parent model (the model on the 1 side, eg, Post).

````
  class Vote << ActiveRecord::Base
  	belongs_to :user
  	belongs_to :voteable, polymorphic: true
  end

  class Post << ActiveRecord::Base
  	belongs_to :user
    has_many :votes, as: :voteable
  end
````


10. What is an ERD diagram, and why do we need it?
<br/><br/>
It's a basic low-level diagram that shows the structure of the website at the model layer. It's a good foundation to use for building a site; it often helps expose any logic errors and it's a good thing to show to others for feedback, as we haven't sunk time into building the UI yet so it's easier to provide honest opinons.