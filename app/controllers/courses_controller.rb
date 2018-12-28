class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list, :is_open]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close,:semester]
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.course_score="暂无评分"
    #@course.update_attributes(:course_score=>"暂无评分")
    @semester=Semester.where(:is_open=>true)
    if @semester==nil||@semester.count>1
      redirect_to courses_path, flash: {success: "暂时不能创建课程课"}
    else
      @course.semester_id=@semester.first.id
    end
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end
  
  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(:open=>true)
      flash={:info => "开通成功"}
    else
      flash={:warning => "开通失败"}
    end
    redirect_to courses_path, flash: {success: "已经成功开通该课程:#{ @course.name}"}
  end
  

   def close
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(:open=>false)
      flash={:info => "关闭成功"}
    else
      flash={:warning => "关闭失败"}
    end
    redirect_to courses_path, flash: {success: "已经成功关闭该课程:#{ @course.name}"}
   end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end
  
  def semester
    @course = current_user.teaching_courses.where(semester: params[:id])
  end

  #-------------------------for students----------------------

  def list

    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 4)
    @course = @courses-current_user.courses
    tmp=[]
    @course.each do |course|
      if course.open==true
        tmp<<course
      end
    end
    @course=tmp
  end

  def select
    @course=Course.find_by_id(params[:id])
    current_user.courses<<@course
    Grade.create(:user_id => current_user.id, :course_id => @course.id)
    flash={:suceess => "成功选择课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  def quit
    @course=Course.find_by_id(params[:id])
    Grade.where(:user_id => current_user.id, :course_id => @course.id).take.destroy()
    current_user.courses.delete(@course)
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 4) if student_logged_in?
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week, :course_score, :semester_id)
  end


end
