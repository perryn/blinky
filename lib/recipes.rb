recipe DelcomEngineering::VisualIndicator::GenerationI,  {:usb_vendor_id => 0x0fc5, 
                                                          :usb_product_id => 0x1223, 
                                                          :description => "USB Visual Signal Indicator Gen I"}
                                         
recipe DelcomEngineering::VisualIndicator::GenerationII,  {:usb_vendor_id => 0x0fc5, 
                                                           :usb_product_id => 0xb080, 
                                                           :description => "USB Visual Signal Indicator Gen II"}
                                                           
recipe ThingM::Blink1,  {:usb_vendor_id => 0x27b8, 
                         :usb_product_id => 0x01ed, 
                         :description => "ThingM Blink(1)"}
                         
recipe DreamCheeky::WebmailNotifier,  {:usb_vendor_id => 0x1d34, 
                                       :usb_product_id => 0x0004, 
                                       :description => "Dream Cheeky Webmail Notifier"}
                                                     
                                              
#TODO - use treeop to allow a syntax like this 

# DelcomEngineering 0x0fc5
#       Model804005 0x1223 "USB HID Visual Signal Indicator RGB"                                             
