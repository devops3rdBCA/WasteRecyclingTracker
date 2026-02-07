# 🌐 DOMAIN NAME CONFIGURATION GUIDE
**Custom Domain**: waste-recycling-tracker.com

---

## 📋 Overview

This guide documents the complete process of configuring a custom domain for the Waste Recycling Tracker application deployed on Vercel.

---

## 1️⃣ Domain Purchase & Registration

### Domain Provider
**Chosen Provider**: [Select one]
- ☐ Namecheap
- ☐ Google Domains
- ☐ GoDaddy
- ☐ Cloudflare Registrar
- ☐ Other: _______

**Domain Details**:
```
Domain Name: waste-recycling-tracker.com
Registration Date: [Date]
Expiry Date: [Date + 1 year]
Auto-Renewal: ✅ Enabled
Privacy Protection: ✅ Enabled
```

**Cost**: ~$10-15/year (Free with GitHub Student Pack via Namecheap)

---

## 2️⃣ Vercel Domain Configuration

### Step-by-Step Setup

#### Step 1: Add Domain in Vercel Dashboard

1. Log in to [Vercel Dashboard](https://vercel.com/dashboard)
2. Select project: `waste-recycling-tracker`
3. Navigate to **Settings** → **Domains**
4. Click **Add Domain**
5. Enter domain: `waste-recycling-tracker.com`
6. Click **Add**

#### Step 2: Configure Domain Records

Vercel will provide DNS records to configure:

**Option A: Using Vercel Nameservers (Recommended)**
```
ns1.vercel-dns.com
ns2.vercel-dns.com
```

**Option B: Using CNAME Records**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
TTL: Auto

Type: A
Name: @
Value: 76.76.21.21
TTL: Auto
```

---

## 3️⃣ DNS Configuration at Domain Registrar

### For Namecheap

1. Log in to [Namecheap Dashboard](https://namecheap.com)
2. Go to **Domain List**
3. Click **Manage** next to your domain
4. Go to **Advanced DNS** tab

**Add DNS Records**:
```
Type          Host    Value                  TTL
────────────────────────────────────────────────────
A Record      @       76.76.21.21           Automatic
CNAME Record  www     cname.vercel-dns.com  Automatic
```

**Or Use Vercel Nameservers**:
1. Go to **Domain** tab
2. Select **Custom DNS**
3. Add nameservers:
   - ns1.vercel-dns.com
   - ns2.vercel-dns.com
4. Save changes

### For Google Domains

1. Log in to [Google Domains](https://domains.google.com)
2. Click on your domain
3. Go to **DNS** section

**Add Resource Records**:
```
Name    Type     TTL      Data
────────────────────────────────────────
@       A        1h       76.76.21.21
www     CNAME    1h       cname.vercel-dns.com
```

### For GoDaddy

1. Log in to [GoDaddy](https://godaddy.com)
2. Go to **My Products** → **DNS**
3. Click **Add** to add records

**DNS Records**:
```
Type     Name    Value                  TTL
───────────────────────────────────────────────
A        @       76.76.21.21           1 Hour
CNAME    www     cname.vercel-dns.com  1 Hour
```

---

## 4️⃣ SSL Certificate Configuration

### Automatic SSL (Vercel Handles This)

Once DNS is configured, Vercel automatically:
1. ✅ Detects DNS propagation
2. ✅ Issues Let's Encrypt SSL certificate
3. ✅ Configures HTTPS
4. ✅ Redirects HTTP → HTTPS

**Certificate Details**:
```
Issuer: Let's Encrypt
Type: Domain Validation (DV)
Encryption: TLS 1.3
Validity: 90 days (auto-renews)
Wildcard: ✅ Supports www subdomain
```

**Verification**:
```bash
# Check SSL certificate
openssl s_client -connect waste-recycling-tracker.com:443 -servername waste-recycling-tracker.com

# Or visit in browser
https://waste-recycling-tracker.com
https://www.waste-recycling-tracker.com
```

---

## 5️⃣ Domain Verification & Testing

### DNS Propagation Check

**Tools**:
- https://dnschecker.org
- https://www.whatsmydns.net
- Command line: `nslookup waste-recycling-tracker.com`

**Check DNS Records**:
```bash
# Windows PowerShell
nslookup waste-recycling-tracker.com
nslookup www.waste-recycling-tracker.com

# Expected Output:
Name:    waste-recycling-tracker.com
Address: 76.76.21.21
```

**Propagation Time**: 
- Typical: 1-4 hours
- Maximum: 24-48 hours
- Depends on: DNS provider, TTL settings, geographic location

### Verify Domain Setup

**Checklist**:
```
✅ DNS A record pointing to Vercel IP
✅ CNAME record for www subdomain
✅ DNS propagation complete (worldwide)
✅ SSL certificate issued and active
✅ HTTPS enforced (HTTP → HTTPS redirect)
✅ www redirects to apex (or vice versa)
✅ No mixed content warnings
✅ All assets loading over HTTPS
```

**Test URLs**:
```
http://waste-recycling-tracker.com
  → Redirects to: https://waste-recycling-tracker.com ✅

https://waste-recycling-tracker.com
  → Loads application ✅

http://www.waste-recycling-tracker.com
  → Redirects to: https://waste-recycling-tracker.com ✅

https://www.waste-recycling-tracker.com
  → Loads application ✅
```

---

## 6️⃣ Environment Variables Update

### Update Frontend Environment

After domain is live, update environment variables:

**Vercel Environment Variables**:
```bash
# Navigate to Vercel Dashboard
# Project Settings → Environment Variables

# Add/Update:
VITE_APP_URL=https://waste-recycling-tracker.com
VITE_API_URL=https://api.waste-recycling-tracker.com
```

**Redeploy**:
```bash
# Trigger redeployment to apply env changes
git commit --allow-empty -m "trigger: apply domain env variables"
git push origin main
```

---

## 7️⃣ Subdomain Configuration (Optional)

### API Subdomain

**Purpose**: Separate API endpoint from frontend

**DNS Configuration**:
```
Type     Name    Value                     TTL
─────────────────────────────────────────────────
CNAME    api     your-backend-host.com    1h
```

**Example**:
```
Frontend: https://waste-recycling-tracker.com
API:      https://api.waste-recycling-tracker.com
Admin:    https://admin.waste-recycling-tracker.com
```

### Staging Subdomain

**For Testing**:
```
Type     Name       Value                  TTL
──────────────────────────────────────────────────
CNAME    staging    staging-deployment     1h
```

**URL**: https://staging.waste-recycling-tracker.com

---

## 8️⃣ Domain Monitoring & Maintenance

### SSL Certificate Monitoring

**Vercel Auto-Renewal**:
- Certificates auto-renew 30 days before expiration
- No manual intervention required
- Email notifications for any issues

**Manual Check**:
```bash
# Check certificate expiry
echo | openssl s_client -servername waste-recycling-tracker.com \
  -connect waste-recycling-tracker.com:443 2>/dev/null | \
  openssl x509 -noout -dates
```

### Domain Renewal

**Set Calendar Reminders**:
- 60 days before expiry: Check auto-renewal status
- 30 days before expiry: Verify payment method
- 7 days before expiry: Ensure renewal completed

**Auto-Renewal Settings**:
```
✅ Auto-renew enabled at registrar
✅ Valid payment method on file
✅ Email notifications enabled
✅ Backup payment method added
```

### Uptime Monitoring

**Tools**:
- UptimeRobot (free tier)
- Pingdom
- StatusCake
- Vercel Analytics (built-in)

**Setup**:
```
Monitor URL: https://waste-recycling-tracker.com
Check Interval: 5 minutes
Alert Email: [Configure your notification email here]
Alert Types: Down, SSL expiry, slow response
```

---

## 9️⃣ Troubleshooting

### Common Issues & Solutions

#### Issue 1: "Domain not found" Error

**Symptoms**: 
- `DEPLOYMENT_NOT_FOUND` error
- 404 page on custom domain

**Solutions**:
```bash
# 1. Check DNS propagation
nslookup waste-recycling-tracker.com

# 2. Verify Vercel configuration
# Vercel Dashboard → Domains → Check status

# 3. Re-add domain in Vercel
# Remove domain → Wait 5 minutes → Add again

# 4. Clear DNS cache (Windows)
ipconfig /flushdns
```

#### Issue 2: SSL Certificate Not Issued

**Symptoms**:
- "Not secure" warning in browser
- Certificate error

**Solutions**:
1. Wait for DNS propagation (up to 48 hours)
2. Check CAA records (should allow Let's Encrypt)
3. Verify domain ownership in Vercel
4. Contact Vercel support if >48 hours

#### Issue 3: DNS Not Propagating

**Check**:
```bash
# Test from different DNS servers
nslookup waste-recycling-tracker.com 8.8.8.8  # Google DNS
nslookup waste-recycling-tracker.com 1.1.1.1  # Cloudflare DNS
```

**Solutions**:
1. Verify DNS records at registrar
2. Check nameserver configuration
3. Reduce TTL values (before changes)
4. Wait longer (can take 48 hours)

#### Issue 4: www Not Working

**Problem**: `waste-recycling-tracker.com` works but `www.waste-recycling-tracker.com` doesn't

**Solution**:
```
# Add CNAME record
Type: CNAME
Host: www
Value: waste-recycling-tracker.com
TTL: 3600
```

---

## 🔟 Cost Breakdown

### Domain Costs

**Annual Expenses**:
```
Domain Registration (.com): $12.98/year
  ├─ With GitHub Student Pack: $0/year (free via Namecheap)
  └─ Without discount: $12.98/year

WHOIS Privacy Protection: $2.99/year
  └─ Often included free

DNS Hosting: $0/year
  └─ Included with Vercel

SSL Certificate: $0/year
  └─ Free Let's Encrypt via Vercel

Total Without Discount: ~$16/year
Total With Student Pack: $0/year
```

**Savings**: $16/year × 4 years = $64 during college

---

## 📊 Domain Performance Metrics

### Analytics Setup

**Vercel Analytics**:
```
✅ Page views
✅ Unique visitors
✅ Top pages
✅ Geographic distribution
✅ Device breakdown
✅ Referrer sources
```

**Google Analytics** (Optional):
```html
<!-- Add to index.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

---

## 📚 Additional Resources

**Documentation**:
- [Vercel Custom Domains](https://vercel.com/docs/concepts/projects/domains)
- [DNS Configuration Guide](https://vercel.com/docs/concepts/projects/domains/dns)
- [SSL Certificate Documentation](https://vercel.com/docs/concepts/projects/domains/add-a-domain#ssl-certificates)

**Tools**:
- DNS Checker: https://dnschecker.org
- SSL Test: https://www.ssllabs.com/ssltest/
- Vercel Support: https://vercel.com/support

---

## ✅ Verification Checklist

Before marking domain setup complete:

```
☐ Domain purchased and registered
☐ DNS records configured at registrar
☐ Domain added in Vercel dashboard
☐ DNS propagation verified (dnschecker.org)
☐ SSL certificate issued automatically
☐ HTTPS enabled and enforced
☐ HTTP redirects to HTTPS
☐ www subdomain working
☐ www redirects to apex domain
☐ All assets loading over HTTPS
☐ No browser security warnings
☐ Environment variables updated
☐ Application accessible via custom domain
☐ API endpoints working through domain
☐ Domain renewal set to auto-renew
☐ Uptime monitoring configured
☐ Analytics tracking active
```

---

## 🎯 Success Metrics

**Domain Setup Complete When**:
1. ✅ Custom domain resolves globally
2. ✅ SSL certificate valid and active
3. ✅ Application loads without errors
4. ✅ All redirects working correctly
5. ✅ Performance metrics within acceptable range

**Current Status**:
```
Domain: waste-recycling-tracker.com
Status: [Propagating / Active]
SSL: [Pending / Issued]
Performance: [Normal / Optimal]
Last Checked: February 2026
```

---

## 📞 Support Contacts

**Vercel Support**:
- Email: support@vercel.com
- Discord: https://vercel.com/discord
- Twitter: @vercel

**Domain Registrar Support**:
- Namecheap: support@namecheap.com
- Google Domains: domains-support@google.com
- GoDaddy: support@godaddy.com

---

**Domain Configuration Guide Complete! 🎉**

Your custom domain `waste-recycling-tracker.com` is now configured and ready to serve your application to the world!

---

**BCA III Year** | **February 2026**
