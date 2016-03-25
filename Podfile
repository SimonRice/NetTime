platform :ios, '8.0'
use_frameworks!

def common_pods
  pod 'RxSwift', '~> 2.3'
  pod 'SwiftDate', '~> 3.0'
end

target 'NetTime' do
  common_pods

  pod 'Appz', git: 'https://github.com/simonrice/Appz.git'
  pod 'Crashlytics', '~> 3.7'
  pod 'Fabric', '~> 1.6'
  pod 'Eureka', '~> 1.5'
  pod 'FontAwesome.swift', '~> 0.7'
  pod 'SwiftyMarkdown', '~> 0.2'
end

target 'NetTimeTests' do
  common_pods

  pod 'Nimble', '~> 3.2'
  pod 'Quick', '~> 0.9'
end

target 'NetTimeUITests' do
  common_pods

  pod 'Nimble', '~> 3.2'
  pod 'SimulatorStatusMagic', git: 'https://github.com/openium/SimulatorStatusMagic.git'
end

target 'NetTimeWatch Extension' do
  common_pods
end

target 'TodayExtension' do
  common_pods
end

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-NetTime/Pods-NetTime-acknowledgements.markdown', 'NetTime/Resources/Acknowledgements.md', remove_destination: true)
end
