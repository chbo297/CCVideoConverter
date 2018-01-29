//
//  ViewController.swift
//  CCVideoConverter
//
//  Created by bo on 18/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

import Cocoa


private let sfs_cell_idf = NSUserInterfaceItemIdentifier(rawValue: "cellidf")
class ViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {

    @IBOutlet weak var addBut: NSButton!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var scrV: NSScrollView!
    @IBOutlet weak var container: NSView!
    @IBOutlet weak var converBut: NSButton!
    @IBOutlet weak var profileLabel: NSTextField!
    @IBOutlet weak var selectBar: NSComboBox!
    @IBOutlet weak var outLabel: NSTextField!
    @IBOutlet weak var desBar: NSTextField!
    @IBOutlet weak var desBut: NSButton!
    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.selectBar.removeAllItems()
        self.selectBar.addItems(withObjectValues: ["mp4","mp3","mov",])
        self.selectBar.selectItem(at: 0)
//        self.selectBar.isEditable = false
        
        addBut.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.leading.equalTo(self.view).offset(20)
            make.size.equalTo(NSSize.init(width: 36, height: 36))
        }
        
        scrV.hasVerticalScroller = false
        scrV.snp.makeConstraints { (make) in
            make.top.equalTo(addBut.snp.bottom).offset(8)
            make.centerX.equalTo(self.view)
            make.width.greaterThanOrEqualTo(325)
            make.height.greaterThanOrEqualTo(132)
            make.width.equalTo(self.view).offset(-40)
        }
        
        profileLabel.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(20)
            make.leading.equalTo(container)
        }
        
        selectBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileLabel)
            make.leading.equalTo(profileLabel.snp.trailing).offset(20)
        }
        
        outLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileLabel.snp.bottom).offset(15)
            make.leading.equalTo(container)
        }
        
        desBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(outLabel)
            make.leading.equalTo(selectBar)
            make.bottom.equalTo(container).offset(-25)
        }
        
        desBut.snp.makeConstraints { (make) in
            make.centerY.equalTo(desBar)
            make.leading.equalTo(desBar.snp.trailing).offset(15)
            make.trailing.equalTo(converBut.snp.leading).offset(-15)
        }
        desBut.setContentCompressionResistancePriority(.required, for: .horizontal)
        desBut.setContentCompressionResistancePriority(.required, for: .vertical)
        desBut.setContentHuggingPriority(.required, for: .horizontal)
        desBut.setContentHuggingPriority(.required, for: .vertical)
        
        converBut.snp.makeConstraints { (make) in
            make.trailing.centerY.equalTo(container)
            make.size.equalTo(NSSize.init(width: 45, height: 45))
        }
        converBut.setContentCompressionResistancePriority(.required, for: .horizontal)
        converBut.setContentCompressionResistancePriority(.required, for: .vertical)
        converBut.setContentHuggingPriority(.required, for: .horizontal)
        converBut.setContentHuggingPriority(.required, for: .vertical)
        
        container.snp.makeConstraints { (make) in
            make.top.equalTo(scrV.snp.bottom).offset(8)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-40)
            make.bottom.equalTo(self.view)
        }
        
        self.collectionView.register(CVDisplayCell.self, forItemWithIdentifier: sfs_cell_idf)
        
    }
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
        
    }
    
    class CCVideoItem : NSObject {
        
        var path : NSString!
        var image : NSImage?
        let originURL : URL
        var info : videoInfo?
        struct videoInfo {
            var title : String?
            var dur : String?
            var format : String?
            
        }
        
        init(url : URL) {
            originURL = url
            path = (url.path as NSString)
            super.init()
        }
        
        
    }
    
    
    var dataAr : [CCVideoItem] = []
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataAr.count
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem
    {
        if let item = collectionView.makeItem(withIdentifier: sfs_cell_idf, for: indexPath) as? CVDisplayCell {
            item.setData(item: self.dataAr[indexPath.item])
            return item
        }
        
        return NSCollectionViewItem.init()
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CVDisplayCell.cellSize(width: collectionView.bounds.size.width)
        
    }
    
    @IBAction func setDestination(_ sender: NSButton) {
        let panel = NSOpenPanel.init()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.begin { (response) in
            if let surl = panel.url {
                self.desBar.stringValue = surl.path
            }
        }
    }
    func addFile(url : URL) {
        let vitem = CCVideoItem.init(url: url)
        self.dataAr.append(vitem)
        self.collectionView.reloadData()
        
        
//        self.getVideoImage(item: vitem, ts: 0) { (path) in
//            if let sp = path {
//                vitem.image = NSImage.init(contentsOf: URL.init(fileURLWithPath: sp))
//                self.collectionView.reloadData()
//            }
//
//        }
//        return
//        print("into get info")
        self.getVideoInfo(path: (url.absoluteString as NSString), completion: { (value) in

            if let sv = value {
                vitem.info = CCVideoItem.videoInfo.init(title: sv, dur: nil, format: nil)
                self.collectionView.reloadData()
            }


            self.getVideoImage(item: vitem, ts: 0) { (path) in
                if let sp = path {
                    vitem.image = NSImage.init(contentsOf: URL.init(fileURLWithPath: sp))
                    self.collectionView.reloadData()
                }

            }
        })
        
        
    }
    
    func getVideoImage(item : CCVideoItem, ts : Int, completion : @escaping (String?) -> Swift.Void) {
        
        var imageget = false;
        

        guard let surl = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else {
            completion(nil)
            return
        }
        let dir = surl.path+"/cvCache"
        if (!FileManager.default.fileExists(atPath: dir)) {
            try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
        }
        
        let hs = abs(item.path.hashValue)
        let soutp = surl.path + "/cvCache/" + String(hs) + "." + "png"
        if (FileManager.default.fileExists(atPath: soutp)) {
            try? FileManager.default.removeItem(atPath: soutp)
            
        }
        let nso = soutp as NSString
        let opc = UnsafeMutablePointer<Int8>.allocate(capacity: 200)
        opc.initialize(to: 0, count: 200)
        memcpy(opc, nso.utf8String, strlen(nso.utf8String))
        
        let argv = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: 12)
        argv[0] = UnsafeMutablePointer<Int8>(mutating: ("ffmpeg" as NSString).utf8String!)
        argv[1] = UnsafeMutablePointer<Int8>(mutating: ("-i" as NSString).utf8String!)
        argv[2] = UnsafeMutablePointer<Int8>(mutating: item.path.utf8String!)
        argv[3] = UnsafeMutablePointer<Int8>(mutating: ("-y" as NSString).utf8String!)
        argv[4] = UnsafeMutablePointer<Int8>(mutating: ("-f" as NSString).utf8String!)
        argv[5] = UnsafeMutablePointer<Int8>(mutating: ("image2" as NSString).utf8String!)
        argv[6] = UnsafeMutablePointer<Int8>(mutating: ("-ss" as NSString).utf8String!)
        argv[7] = UnsafeMutablePointer<Int8>(mutating: ("3" as NSString).utf8String!)
        argv[8] = UnsafeMutablePointer<Int8>(mutating: ("-vframes" as NSString).utf8String!)
        argv[9] = UnsafeMutablePointer<Int8>(mutating: ("1" as NSString).utf8String!)
        argv[10] = UnsafeMutablePointer<Int8>(mutating: opc)
        
        DispatchQueue.cc_async_main(deley: 3) {
            if (!imageget) {
                opc.deallocate(capacity: 200)
                imageget = true
                completion(nil)
            }
        }
        
        Thread.detachNewThread {
            ffmpeg_main(11, argv)
            print("\(nso)");
            DispatchQueue.main.sync {
                if (!imageget) {
                    opc.deallocate(capacity: 200)
                    imageget = true
                    completion(soutp)
                }
            }
            
            cc_exitThread()
        }
    }
    
    func getVideoInfo(path : NSString, completion : @escaping (String?) -> Swift.Void) {
        var infoget = false
        let argv = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: 3)
        argv[0] = UnsafeMutablePointer<Int8>(mutating: ("ffmpeg" as NSString).utf8String!)
        argv[1] = UnsafeMutablePointer<Int8>(mutating: ("-i" as NSString).utf8String!)
        argv[2] = UnsafeMutablePointer<Int8>(mutating: (path as NSString).utf8String!)
        

        DispatchQueue.cc_async_main(deley: 3) {
            if (!infoget) {
                infoget = true
                completion(nil)
                return
            }
        }
        
        Thread.detachNewThread {
            
            let char = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: 1)
            let size = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
            size.initialize(to: 0)
            cc_ffmpegGetInfo(3, argv, char, size)
            
            DispatchQueue.main.sync {
                if (!infoget) {
                    infoget = true
                    completion(NSString.init(utf8String: char[0]!) as! String)
                    return
                }
            }
            cc_exitThread()
            
        }
        
        
        
        
    }
    
    
    
//    - (void)setNewestInputVideoPath:(NSString *)inputPath
//    {
//
//    int argc = 4;
//    char **arguments = calloc(argc, sizeof(char*));
//
//    char *ipath = (char *)[inputPath UTF8String];
//    NSString *outpath = [inputPath stringByDeletingLastPathComponent];
//    outpath = [outpath stringByAppendingPathComponent:@"ouou.mp3"];
//    
//    NSString *stt = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject.path;
//    stt = [stt stringByAppendingPathComponent:@"ou.mp4"];
//
//    NSLog(@"inpath:%s\noutpath:%s", ipath, stt.UTF8String);
//    if(arguments != NULL)
//    {
//    arguments[0] = "ffmpeg";
//    arguments[1] = "-i";
//    arguments[2] = ipath;
//    arguments[3]= (char *)stt.UTF8String;
//
//    ffmpeg_main(argc, arguments);
//    }
//
//    }
    
    func __converte(opath : String, topath : String, completion :@escaping (String?, String?) ->Swift.Void) {
        var videoget = false;
        
        let nsto = topath as NSString
        let opc = UnsafeMutablePointer<Int8>.allocate(capacity: 200)
        opc.initialize(to: 0, count: 200)
        memcpy(opc, nsto.utf8String, strlen(nsto.utf8String))
        
        let argv = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: 12)
        argv[0] = UnsafeMutablePointer<Int8>(mutating: ("ffmpeg" as NSString).utf8String!)
        argv[1] = UnsafeMutablePointer<Int8>(mutating: ("-i" as NSString).utf8String!)
        argv[2] = UnsafeMutablePointer<Int8>(mutating: (opath as NSString).utf8String!)
        argv[3] = UnsafeMutablePointer<Int8>(mutating: opc)
        
        DispatchQueue.cc_async_main(deley: 1800) {
            if (!videoget) {
                opc.deallocate(capacity: 200)
                videoget = true
                completion(nil, "over time")
            }
        }
        
        Thread.detachNewThread {
            ffmpeg_main(4, argv)
            
            DispatchQueue.main.sync {
                if (!videoget) {
                    opc.deallocate(capacity: 200)
                    videoget = true
                    completion(topath, nil)
                }
            }
            
            cc_exitThread()
        }
    }
    
    @IBAction func converte(_ sender: Any) {
        
        guard let spath = self.dataAr.first?.path else {
            return
        }
        
        var desdirpath : String = ""
        
        if self.desBar.stringValue.count == 0 {
            
            desdirpath = spath.deletingLastPathComponent
            self.desBar.stringValue = desdirpath
            
        } else {
            desdirpath = self.desBar.stringValue
        }
        
        
        let isdir = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        isdir.initialize(to: ObjCBool.init(false))
        let isexist = FileManager.default.fileExists(atPath: desdirpath, isDirectory: isdir)
        guard isexist, isdir.pointee.boolValue else {
            return
        }
        
        let filename = spath.lastPathComponent
        let dfn = filename.replacingOccurrences(of: spath.pathExtension, with: self.selectBar.itemObjectValue(at: self.selectBar.indexOfSelectedItem) as! String)
        
        let desfina = (desdirpath as NSString).appendingPathComponent(dfn)
        
        self.__converte(opath: spath as String, topath: desfina) { (path, errmes) in
            print("convert finish :\(errmes)")
        }
        
        
        
    }
    
    @IBAction func tapAdd(_ sender: NSButton) {
        
        let panel = NSOpenPanel.init()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.begin { (response) in
            if let surl = panel.url {
                self.addFile(url: surl)
            }
        }
        
//        NSOpenPanel *panel = [NSOpenPanel openPanel];
//
//        [panel setCanChooseFiles:true];  //是否能选择文件file
//
//        [panel setCanChooseDirectories:true];  //是否能打开文件夹
//
//        [panel setAllowsMultipleSelection:false];  //是否允许多选file
//
//        [panel beginWithCompletionHandler:^(NSModalResponse result) {
//
//            NSString *str = panel.URL.path;
//            if (str) {
//            NSLog(@"%@", str);
//            NSThread *td = [[NSThread alloc] initWithBlock:^{
//            [self setNewestInputVideoPath:str];
//            }];
//
//            [td start];
//
//            }
//
//            }];
    }
}

