class ApplicationController < ActionController::Base
    # handle general error
    rescue_from Exception do |e|
        render json: { error: e.message }
    end
    before_action :start_period, :end_period, :allow_cors

    def start_period
        @start_period ||= (Time.now - 1.year).beginning_of_year
    end

    def end_period
        @end_period ||= Time.now.end_of_year
    end

    def allow_cors
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
end
