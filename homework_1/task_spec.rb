require "rspec"
require "./task"

RSpec.describe "Task" do
  it "returns greeting message if user younger than 18" do
    expect(greeting("Ivan", "Ivanov", 17)).to eq(
      "Привет, Ivan Ivanov. Тебе меньше 18 лет," \
      " но начать учиться программировать никогда не рано."
    )
  end

  it "returns greeting message if user older than 18" do
    expect(greeting("Ivan", "Ivanov", 18)).to eq(
      "Привет, Ivan Ivanov. Самое время заняться делом!"
    )
  end

  it "returns second number if first number is 20" do
    expect(foobar(20, -12)).to eq(-12)
  end

  it "returns second number if second number is 20" do
    expect(foobar(333, 20)).to eq(20)
  end

  it "returns second number if first and second number are 20" do
    expect(foobar(20, 20)).to eq(20)
  end

  it "returns sum of numbers if first and second number are not 20" do
    expect(foobar(300, 700)).to eq(1000)
  end

  it "returns sum of numbers if first and second number are not 20" do
    expect(foobar(-50, -10)).to eq(-60)
  end
end
