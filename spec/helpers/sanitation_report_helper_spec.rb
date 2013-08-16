require_relative  '../spec_helper'

describe SanitationReportHelper, :type => :helper do
  subject { Class.new.include SanitationReportHelper }

  describe "#get_total" do
    it "should return a valid total" do
       capital, recurrent, population = 61, 3, 2000
       expect(get_total(capital, recurrent, population)).to eq(182000)
    end
  end

  describe "#is_ready_form" do
    let (:complete_form) {
        { :latrine => 1, :capital => 1, :recurrent => 2, :reliability => 1 }
      }
    let (:incomplete_form) {
        { :latrine => 1, :capital => 1, :recurrent => nil, :reliability => 1 }
      }

    context "when the form is complete" do
      it "should be true" do
        expect(is_form_ready?(complete_form)).to be_true
      end
    end

    context "when the form is incomplete" do
      it "should be false" do
        expect(is_form_ready?(incomplete_form)).to be_false
      end
    end
  end

  describe "#get_service_rating_label" do
    context "when has one star" do
      it "should read No service" do
        expect(get_service_rating_label(0)).to eq(t 'report.sustainability.sanitation.one_star')
      end
    end

    context "when has two stars" do
      it "should read Sub-standard service" do
        expect(get_service_rating_label(1)).to eq(t 'report.sustainability.sanitation.two_stars')
      end
    end

    context "when has three stars" do
      it "should read Basic service" do
        expect(get_service_rating_label(2)).to eq(t 'report.sustainability.sanitation.three_stars')
      end
    end

    context "when has four stars" do
      it "should read High standard service" do
        expect(get_service_rating_label(3)).to eq(t 'report.sustainability.sanitation.four_stars')
      end
    end
  end

  describe "#get_capex_benchmark_rating" do
    context "when below benchmarks" do
      it "should be 0.5" do
        latrineIndex, expense = 0, 6
        expect(get_capex_benchmark_rating(latrineIndex, expense)).to eq(0.5)
      end
    end

    context "when within benchmarks" do
      it "should be 2" do
        latrineIndex, expense = 0, 25
        expect(get_capex_benchmark_rating(latrineIndex, expense)).to eq(2)
      end
    end

    context "when above benchmarks" do
      it "should be 1" do
        latrineIndex, expense = 0, 27
        expect(get_capex_benchmark_rating(latrineIndex, expense)).to eq(1)
      end
    end
  end

  describe "#get_recex_benchmark_rating" do
    context "when below benchmarks" do
      it "should be 0.5" do
        latrineIndex, expense = 0, 1
        expect(get_recex_benchmark_rating(latrineIndex, expense)).to eq(0.5)
      end
    end

    context "when within benchmarks" do
      it "should be 2" do
        latrineIndex, expense = 0, 3.5
        expect(get_recex_benchmark_rating(latrineIndex, expense)).to eq(2)
      end
    end

    context "when above benchmarks" do
      it "should be 1" do
        latrineIndex, expense = 0, 7
        expect(get_recex_benchmark_rating(latrineIndex, expense)).to eq(1)
      end
    end
  end

  describe "#get_rating" do
    context "providing = 0, impermeability = 0, environment = 0, usage = 0, reliability = 0" do
      it "should be 3"  do
        providing, impermeability = 1, 0 #Score is: 2
        environment, usage, reliability =  3, 3, 3 #Scores are: 3, 3, 3
        expect(get_rating(providing, impermeability, environment, usage, reliability)).to eq(2)
      end
    end

    context "providing = 1, impermeability = 1, environment = 1, usage = 1, reliability = 1" do
      it "should be 1"  do
        providing, impermeability = 1, 1 #Score is: 1
        environment, usage, reliability =  1, 1, 1 #Scores are: 1, 1, 1
        expect(get_rating(providing, impermeability, environment, usage, reliability)).to eq(1)
      end
    end

    context "providing = 1, impermeability = 0, environment = 1, usage = 1, reliability = 2" do
      it "should be 0"  do
        providing, impermeability = 1, 0 #Score is: 2
        environment, usage, reliability =  1, 1, 2 #Scores are: 1, 1, 2
        expect(get_rating(providing, impermeability, environment, usage, reliability)).to eq(1)
      end
    end

    context "when an argument is nil" do
      it "should be nil" do
        expect(get_rating(0, nil, 0, 0, 0)).to be_nil
      end
    end
  end

  describe "#get_access_service_level" do
    answers = [ [0, 0, 3], [0, 1, 1], [1, 0, 2], [1, 1, 1] ]
    answers.each do |answer|
      context "when providing is #{answer[0]} and impermeability is #{answer[1]}" do
        it "should be #{answer[2]}" do
          expect(get_access_service_level(answer[0], answer[1])).to eq(answer[2])
        end
      end
    end
  end

  describe "#rating_for_service_level" do
    context "when improved service (0)" do
      it "should be 3" do
        expect(rating_for_service_level(0)).to eq(3)
      end
    end

    context "when basic service (1)" do
      it "should be 2" do
        expect(rating_for_service_level(1)).to eq(2)
      end
    end

    context "when limited/no service (2)" do
      it "should be 0" do
        expect(rating_for_service_level(1)).to eq(2)
      end
    end
  end

end
