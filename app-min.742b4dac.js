n.prototype.loadAdSlot = function () {
                    return googletag.cmd.push(function (t) {
                        return function () {
                            var n, r, o, s, a, u, l;
                            return u = "sponsT" === (l = t.adPosition) || "sponsM" === l ? googletag.defineSlot(t.dfpUnitPath, t.adSize, t.slotName).setCollapseEmptyDiv(!0, !0) : googletag.defineSlot(t.dfpUnitPath, t.adSize, t.slotName).setCollapseEmptyDiv(!0), u.setTargeting("pos", t.adPosition), o = e("." + t.adPosition).first().attr("data-position-meta"), "article" === o && (n = e("#dfp-ad-" + t.adPosition), r = t.adPosition.match(/^mid(\d+)/)[1], a = n.attr("data-p-location"), s = {
                                subject: "module-interactions",
                                moduleData: {
                                    module: "ad",
                                    mdata: {"mobilearticle-ad-number": r, "mobilearticle-paragraph-location": a}
                                }
                            }, i.track(s)), googletag.pubads().addEventListener("slotRenderEnded", function (n) {
                                var r, i, o, s, a, u;
                                o = n.slot.getSlotId(), u = [];
                                for (s in o)a = o[s], o.hasOwnProperty(s) && "string" == typeof a && a.match(/^dfp-ad-/) ? (r = e("#" + a), r.addClass("dfp-size-" + n.size[0] + "x" + n.size[1]), 300 !== n.size[0] || 50 !== n.size[1] || n.isEmpty || e(".mid1").addClass("sponsored"), t.isUpshotArticle && "sponsT" === r.attr("data-position") ? (i = r.parents("[data-view=article-page]").first(), i.find("#" + a + ":visible").length ? u.push(i.addClass("has-sponsT")) : u.push(void 0)) : u.push(void 0)) : u.push(void 0);
                                return u
                            }), u.addService(googletag.pubads()), window.advBidxc && window.advBidxc.setTargetingForAdUnitsGPTAsync(), console.log("Enabled"), googletag.display(t.slotName), googletag.pubads().refresh([u], {changeCorrelator: !1})
                        }
                    }(this))
                }