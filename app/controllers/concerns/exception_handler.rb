module ExceptionHandler
  # モジュールを読み込んだときにインスタンスメソッドもクラスメソッドも両方読み込める。
  extend ActiveSupport::Concern

  # このブロック内にメソッドを定義しておくと、モジュールがincludeされたあとににそのメソッドが動作する。
  included do
    rescue_from StandardError, with: :render_500

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActiveRecord::RecordInvalid, with: :render_400

    rescue_from ActionController::ParameterMissing, with: :render_400
  end

  private

  def render_400(exception = nil, messages = nil)
    render_error(400, 'Bad Request', exception&.message, *messages)
  end

  def render_401(exception = nil, messages = nil)
    render_error(401, 'Unauthorized', exception&.message, *messages)
  end

  def render_403(exception = nil, messages = nil)
    render_error(403, 'Forbidden', exception&.message, *messages)
  end

  def render_404(exception = nil, messages = nil)
    render_error(404, 'Record Not Found', exception&.message, *messages)
  end

  def render_500(exception = nil, messages = nil)
    render_error(500, 'Internal Server Error', exception&.message, *messages)
  end

  def render_error(code, message, *error_messages)
    response = {
      message: message,
      # compactメソッドは配列から「nil」を取り除いた新しい配列を返す。
      errors: error_messages.compact
    }

    render json: response, status: code
  end
end
