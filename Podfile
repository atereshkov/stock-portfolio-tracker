# platform :ios, '9.0'

def app_pods
  use_frameworks!
  
  # Core
  pod 'DICE', '~> 0.9.0'
  
  # Firebase
  pod 'Firebase/Analytics'
end

target 'stock-portfolio-tracker' do
  app_pods

  target 'stock-portfolio-trackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'stock-portfolio-trackerUITests' do
    # Pods for testing
  end
end

target 'stock-portfolio-tracker-prod' do
  app_pods
end
