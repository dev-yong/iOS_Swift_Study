# Exploring AVFoundation

- ### Understanding the Asset Model

  AVFoundation : Media asset의 재생 및 처리, AVAsset 클래스를 사용

  - **AVAsset**
    - **로컬 파일 기반 미디어**(QuickTime동영상 또는 MP3오디오 파일)를 모델링 할 수 있으며, 원격 호스트에서 다운로드하거나 **HTTP 실시간 스트리밍**(HLS)을 사용하여 스트리밍되는 asset
    - media format에 대한 독립성을 제공. 일관된 인터페이스
    - media의 위치로부터 독립성을 제공. **URL로 초기화** 하여 생성
    - AVAssetTrack인스턴스로 구성된 컨테이너 개체
    - Video, Audio, Subtitles


- ### Creating an Asset

  ```swift
  var anAsset = AVURLAsset(url: url, options: nil)
  ```

  HLS스트림에 대한 자산을 생성하는 경우 사용자가 셀룰러 네트워크에 연결되어 있을 때 해당 미디어가 해당 미디어를 검색하지 못하도록 할 수 있습니다. `AVURLAssetAllowsCellularAccessKey`

  ```swift
  let url: URL = // Remote Asset URL
  let options = [AVURLAssetAllowsCellularAccessKey: false]
  let asset = AVURLAsset(url: url, options: options)
  ```


- ### Preparing Assets for Use

  unloaded property value를 검색하는 요청은 오랫동안 블락되면,  타임아웃이 발생합니다. 이러한 일을 방지하기 위해, asset properties를 **asynchronously 로드**해야합니다.

  AVAsset과 AVAssetTrack은 **AVAsynchronousKeyValueLoading protocol** (property의 현재의 loaded state를 묻고 asynchronously 로드)를 사용합니다.

  ```swift
  public func loadValuesAsynchronously(forKeys keys: [String], completionHandler handler: (() -> Void)?)
  public func statusOfValue(forKey key: String, error outError: NSErrorPointer) -> AVKeyValueStatus
  ```

  `statusOfValueForKey:error:`를 사용하여 완료 콜백에서 속성 상태를 확인합니다.

   모든 경우에 완료 콜백은 임의의 백그라운드 대기 열에서 호출됩니다.