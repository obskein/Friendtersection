require 'spec_helper'
describe ApplicationHelper do
  context 'rendering likes' do
    before(:each) do
    end
    it 'can render likes' do
      @example_likes = [ ]
      likes = helper.render_likes @example_likes
      likes.should == "<ul></ul>"
    end
    it 'can render likes' do
      @example_likes = [ 
        { "created_time" => Time.now.to_s, "category" => 'the category', "name" => 'name 1' },
        { "created_time" => Time.now.to_s, "category" => 'morecategory', "name" => 'name 2' },
      ]
      likes = helper.render_likes @example_likes
      likes.should == [
        "<ul>",
          "<li>name 1, the category, created at #{Time.now.to_s(:short)}</li>",
          "<li>name 2, morecategory, created at #{Time.now.to_s(:short)}</li>",
        "</ul>"
      ].join
    end
  end

  it 'can render a user' do
    mock_user = { "b" => 'value2', "a" => 'value1', "c" => 'value3' }
    user = helper.render_user mock_user
    user.should == [
      "<dl>",
        "<dt>A</dt><dd>value1</dd>",
        "<dt>B</dt><dd>value2</dd>",
        "<dt>C</dt><dd>value3</dd>",
      "</dl>"
    ].join
  end
end
