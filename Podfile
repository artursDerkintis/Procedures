source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

project 'Procedures.xcodeproj'

inhibit_all_warnings!
use_frameworks!


def pods
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
  pod 'RxDataSources', '~> 3.0'
end

def testing_pods
  pods
  pod 'Nimble', '~> 7.0'
  pod 'Quick', '~> 1.1'
end

target 'Procedures' do
	pods
end

target 'ProceduresTests' do
	testing_pods
end
