; uses a web worker background thread
(let [metronome-worker-js "self.onmessage=function(e){setTimeout(function(){postMessage(e.data);},e.data.interval);};console.log('Metronome worker loaded.');"
      worker-blob (js/Blob. (clj->js [metronome-worker-js]) {:type "application/javascript"})
      worker (js/Worker. (.createObjectURL js/URL worker-blob))
      call-id (atom 0)]

  (defn make-worker-listener [id callback]
    (fn [e]
      (when (= e.data.id id)
        (callback)
        true)))

  (defn set-timeout [callback interval]
    (let [id (swap! call-id inc)
          listener-fn (make-worker-listener id callback)]
      (.addEventListener worker
                         "message"
                         (fn [e]
                           (when (listener-fn e) (.removeEventListener worker "message" listener-fn)))
                         false)
      (.postMessage worker (clj->js {:id id :interval interval})))))

(set-timeout (fn [] "Hello!") 1000)
