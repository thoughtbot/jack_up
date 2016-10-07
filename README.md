# Deprecated as of October 7, 2016

Given other [both](https://shubox.io/) [paid](https://www.filestack.com/) and
[free](http://josephndungu.com/tutorials/ajax-file-upload-with-dropezonejs-and-paperclip-rails)
uploading tools available, JackUp has been deprecated.

# JackUp

## Easy AJAX file uploading in Rails.

### Install

Modify your `Gemfile`:

```ruby
gem 'jack_up'
```

and run `bundle install` from your shell.

Modify your `application.js` manifest:

```javascript
//= require jquery
//= require underscore
//= require jack_up
//= require_tree .
```

### Requirements

Rails 4.0+, CoffeeScript, and both jQuery and
Underscore.js included in your `application.js` manifest.

### Usage

Create a JackUp.Processor, binding to various events emitted.

```coffeescript
$ -> # when the document is ready
  # create a new processor with the endpoint to where your assets are uploaded
  jackUp = new JackUp.Processor(path: '/assets')

  # called if upload is an image; returns an image jQuery object with src attribute assigned
  jackUp.on 'upload:imageRenderReady', (e, options) ->
    # assigns a data-attribute with the file guid for later referencing
    # set the border color to red, denoting that the image is still being uploaded
    options.image.attr("data-id", options.file.__guid__).css(border: "5px solid red")
    $('.file-drop').append(options.image)

  # upload has been sent to server; server will handle processing
  jackUp.on "upload:sentToServer", (e, options) ->
    # change the border color to yellow to signify successful upload (server is still processing)
    $("img[data-id='#{options.file.__guid__}']").css borderColor: 'yellow'

  # when server responds successfully
  jackUp.on "upload:success", (e, options) ->
    # server has completed processing the image and has returned a response
    $("img[data-id='#{options.file.__guid__}']").css(borderColor: "green")

  # when server returns a non-200 response
  jackUp.on "upload:failure", (e, options) ->
    # alert the file name
    alert("'#{options.file.name}' upload failed; please retry")
    # remove the image from the dom since the upload failed
    $("img[data-id='#{options.file.__guid__}']").remove()

```

Once the processor is set up, wire up drag-and-drop support:

```coffeescript
  $('.file-drop').jackUpDragAndDrop(jackUp)

  # if you do not want the browser to redirect to the file when droped anywhere else on the page
  $(document).bind 'drop dragover', (e) ->
    e.preventDefault()
```

If you just want to bind to a standard `<input type='file'>`:

```coffeescript
  $('.standard-attachment').jackUpAjax(jackUp)
```

You can use both at the same time, referencing the same `JackUp.Processor`, in
order to provide both options to your users.

### Example Rails Setup

For instant file uploading:

```ruby
# Gemfile
gem 'rails'
gem 'paperclip'
gem 'rack-raw-upload'
```

Using the `rack-raw-upload` gem allows for accessing the file posted to the
controller via `params[:file]`; this makes it incredibly easy to handle file
uploads.

```ruby
# app/models/asset.rb
class Asset < ActiveRecord::Base
  has_attached_file :photo
end

# app/controllers/assets_controller.rb
class AssetsController < ApplicationController
  def create
    @asset = Asset.new(photo: asset_params[:file])

    if @asset.save
      render json: @asset
    else
      head :bad_request
    end
  end

  private

  def asset_params
    params.permit(:file)
  end
end
```

This view code could be placed anywhere for immediate uploading:

```haml
.file-drop
  %span{ 'data-placeholder' => 'Drop files here' } Drop files here

%input.standard-attachment{ name: 'standard_attachment', accept: 'image/*', type: :file, multiple: :multiple }
```

Anything with a data-placeholder attribute will be hidden when an file is successfully dropped.

If attaching assets to a different model, additionally use:

```ruby
# app/models/post.rb
class Post < ActiveRecord::Base
  has_many :assets, dependent: :destroy

  accepts_nested_attributes_for :assets
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.assets.build
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with @post
  end

  private

  def post_params
    params.require(:post).permit(:asset_ids, :assets_attributes)
  end
end
```

To wire up the posts view:

```haml
# app/views/posts/new.html.haml
= form_for @post, html: { multipart: true } do |form|
  = form.text_field :title, { placeholder: 'Title' }

  .file-drop
    %span{ 'data-placeholder' => 'Drop files here' } Drop files here

  %input.standard-attachment{ name: 'standard_attachment', accept: "image/*", type: :file, multiple: :multiple }

  = form.submit 'Create Post'
```

```coffeescript
# app/assets/javascripts/posts.coffee
# truncated from above to demonstrate additional code to associate uploads
# with posts
jackUp.on "upload:success", (e, options) ->
  $("img[data-id='#{options.file.__guid__}']").css(borderColor: "green")

  # read the response from the server
  asset = JSON.parse(options.responseText)
  assetId = asset.id
  # create a hidden input containing the asset id of the uploaded file
  assetIdsElement = $("<input type='hidden' name='post[asset_ids][]'>").val(assetId)
  # append it to the form so saving the form associates the created post
  # with the uploaded assets
  $(".file-drop").parent("form").append(assetIdsElement)
```

## License

JackUp is copyright 2012-2013 Josh Steiner, Josh Clayton, and thoughtbot, inc., and may be redistributed under the terms specified in the LICENSE file.
