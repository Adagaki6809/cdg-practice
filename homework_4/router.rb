# frozen_string_literal: true

# provides functionality to call CRUD methods on given routes
module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

# defines CRUD operations for posts
class PostsController
  extend Resource

  def initialize
    @posts = ['First post', 'Second post', 'Third post']
  end

  def index
    @posts.each_with_index { |post, index| puts "#{index}. #{post}" }
  end

  def show
    print 'Choose post id to show: '
    id = gets.to_i
    puts "#{id}. #{@posts[id]}"
  end

  def create
    print 'Enter text to create post: '
    text = gets.chomp
    id = @posts.push(text).size - 1
    [id, text]
  end

  def update
    print 'Choose post id to update: '
    id = gets.to_i
    print 'Enter text to update choosen post: '
    text = gets.chomp
    @posts[id] = text
    puts "#{id}. #{@posts[id]}"
  end

  def destroy
    print 'Choose post id to destroy: '
    id = gets.to_i
    @posts.delete_at(id)
  end
end

# defines routes for given resourses
class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
