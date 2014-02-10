# Week 2 Quiz
1. Name all the 7 (or 8) routes exposed by the `resources` keyword in the `routes.rb` file. Also name the 4 named routes, and how the request is routed to the controller/action.

```
	resources :posts

	path, routes, controller/action

	GET /posts posts#index (posts_path)
	POST /posts posts#create (posts_path)
	GET /posts/new posts#new (new_post_path) 
	GET /posts/:id/edit posts#edit (edit_post_path)
	GET /posts/:id posts#show (post_path) 
	PATCH /posts/:id posts#update (post_path)
	PUT /posts/:id posts#update (post_path)
	DELETE /posts/:id posts#destroy (post_path)
```

2. What is REST and how does it relate to the `resources` routes?

(Did we talk about this during the week? I frankly don't recall it and don't see it in my notes, so this answer is a rephrasing of Googled answers.)
REST stands for REpresentational State Transfer. A representation of a resource is returned to a client, placing it in a state. When the client goes to a new URL, a new representation is returned, placing the client in a new state. The HTTP based web is a RESTful system. There are several important features of a REST system. It is defined by a client-server separation, where clients are not concerned with e.g. data storage and servers are not concerned with e.g. rendering the page. It is "stateless," which means that no client information is stored on the server between requests that modify the client's state. Responses should also be cacheable by the client.

3. What's the major difference between model backed and non-model backed form helpers?

Model-backed form helpers refer to specific elements of an object that are present in the
database. This limits significantly what values you can assign them to. #Added from sol'n: this means that model-backed form helpers are suitable for create/edit/update actions on an object that is present in your database.

4. How does `form_for` know how to build the `<form>` element?

It's a rails form helper that operates based on a specific object in the model. It has been designed to build forms that work with the attributes of that object. #rephrased answer slightly after solutions

5. What's the general pattern we use in the actions that handle submission of model-backed forms (ie, the `create` and `update` actions)?

```
@object = Object.new(params.require(:object).permit(:object_attribute_1, etc.))

if @object.save
	flash[:notice] = "some notice"
	redirect_to %(index page or saved object, as appropriate)
else
	render %(current page) # pop up an error message, as errors are attached to object
```

6. How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?

The required validations are set up for an object at the model layer (edit w/sol'n: and are triggered when the application tries to hit the database.) If an object's attributes do not meet all of the validation requirements, the object is not saved and instead errors are attached to the object. We would then render the page the user was already on.It should contain a code or a link to a partial such that if object.errors.any? is true, we render object.errors.full_messages.each.

7. What are Rails helpers?

Rails helpers are functions that abstract out bits of repetitive logic used throughout an application, such as modifying timestamps to make more readable creation times. They are stored in the app>helpers directory, from which they can be called simply by typing the function name. Helpers that should be available to the entire application should be stored in application_helper.rb, while helpers that should only be available to one controller/set of views should be stored in specific_object_helper.rb

8. What are Rails partials?

Rails partials are fragments of a view that contain bits of erb/html/etc. that are reused throughout the application. They can be called with <%= render 'partial path', (variable in partial): (thing variable in partial is set to in this view) %>

9. When do we use partials vs helpers?

We should use partials if there's significant erb/html code that's going into the final view. Use helpers for modifications of small aspects of a view. (Edit: "when there is logic to be processed" in the solution is a nicer way of phrasing it.)

10. When do we use non-model backed forms?

We haven't really used them at all in this module, but it's been mentioned that we will when we implement authentication in an upcoming module. They are used when for various reasons when you want to store information in variables that are not attributes of a database object (This sentence heavily modified/rephrased from solutions). It's generally a best practice to use them if possible.